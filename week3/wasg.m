function WASG
% CUED Wing Analysis Surface Generator
% RGM - developed for SA1 2020
% based on 'ManipulateData.m' written by Lindo Ouseph.
%
% Manipulate an aerofoil section with the trailing edge fixed at
% (x,y)=(1,0) interactively. The aerofoil shape is constructed using
% splines based on a list of nodes.
%
% WASG is designed to be run on your main SA1 folder, one level above
% the 'Geometry' folder.
%
% List of functions:
%  left mouse click - select a node, or create a new one if clicking on
%             the aerofoil between points.
%  click and drag left mouse button - move the selected point.
%  arrow keys - move the selected point at a rate 'delta'.
%  right mouse click - delete the node clicked on.
%  u - undo last action (up to 20).
%  r - redo, cancel last undo.
%  z - zoom, create a secondary magnified figure, centred on the last
%      cursor position, that the control is
%      temporarily transferred to. Pressing z again closes the second
%      figure and returns control to the primary one. Functions 'l', 's',
%      'b', and 't' are not available while in zoom mode.
%  l - load aerofoil from a '.surf' file.
%  s - save aerofoil into a '.surf' file.
%  b - back up aerofoil layout into a memory buffer.
%  t - restore aerofoil from backup 'b'.
%  d - delta, reset the rate of displacement of nodes when using the arrow
%      keys.

clear, close all

b=0;p=0;
delta=1e-4;
max_undo = 20;
xmax = 1.0;
xmin = 0.0;
ymax =  .2;
ymin = -.2;
c=0;
full=0;
has_ref=0;
show_ref=0;

pathin=[pwd,'/Geometry/'];
[filein,pathin]=uigetfile([pathin '*.surf']);
y=load([pathin,filein]);
x=y(2:end-1,1);
y=y(2:end-1,2);
x_ref = zeros(size(x));
y_ref = zeros(size(y));
L=length(x);
I=(x-1).^2+y.^2; I=find(I==max(I)); I=I(1);
Xbk=x;
Ybk=y;hZ=[];
axisZ=[];
aZ=[];
deltaZ=.2*delta;
deltxt=8e-3;
deltxtZ=1e-3;
Xbk=x;Ybk=y;Lmax=L;
xundo=[];yundo=[];
Lundo=[];Iundo=[];
xredo=[];yredo=[];
Lredo=[];Iredo=[];
Res=get(0); Res=Res.ScreenSize;
h=figure('units','normalized',...
    'outerposition',[.05 .2 1.35*Res(4)/Res(3) .6],...
    'DockControls','off',...
    'MenuBar','none',...
    'name','Wing Analysis Section Generator (Matlab version)',...
    'NumberTitle','off',...
    'WindowKeyPressFcn',@Key,...
    'windowbuttondownfcn',@Down,...
    'WindowButtonMotionFcn',@Move,...
    'WindowButtonUpFcn',@Up,...
    'DeleteFcn',@figDelete);
a=axes('position',[.10,.10,.87,.87]);
[xs ys] = splinefit([1;x;1],[0;y;0],0);
plot(xs,ys,'k', ...
     [1;x],[0;y],'.k', ...
     'markersize',13,'markerfacecolor','k');
axis equal
axis([xmin xmax ymin ymax])
uicontrol('style','text','Fontsize',10, ...
    'position',[1 190 80 150],...
    'string',{'u-undo';'r-redo';'z-zoom';'l-load';'s-save'; ...
              'b-back up';'t-restore';'d-delta'},...
    'foregroundcolor','k');

    function plot_curvature(xs, ys)
        if c == 1
            dx = gradient(xs);
            dy = gradient(ys);
            ddx = gradient(dx);
            ddy = gradient(dy);

            kappa = (dx.*ddy - dy.*ddx) ./ (dx.^2 + dy.^2).^(1.5);
            scale = 0.005; 
            comb_length = kappa * scale;

            nx = -dy ./ sqrt(dx.^2 + dy.^2);

            ny = dx ./ sqrt(dx.^2 + dy.^2);
            hold on
            quiver(xs(1:20:end), ys(1:20:end), -comb_length(1:20:end).*nx(1:20:end), -comb_length(1:20:end).*ny(1:20:end), 0, 'r', 'ShowArrowHead', 'off');
            hold off
        end
    end


    function plot_all(x, y)
        [xs ys] = splinefit([1;x;1],[0;y;0],0);
        try delete(t);end;
        plot(xs,ys,'k', ...
            [1;x],[0;y],'.k', ...
            x(I),y(I),'xk','markersize',13)

        if show_ref
            hold on
            [xs_ref ys_ref] = splinefit([1;x_ref;1],[0;y_ref;0],1);
            plot(xs_ref,ys_ref,'--b', ...
                [1;x_ref],[0;y_ref],'.--b')
            hold off
        end

        plot_curvature(xs,ys);
        
        axis equal
        if full==1
            axis([-0.5 1 -.2 .2])
        else
            axis([0 1 -.2 .2])
        end
        t=text(x(I)+deltxt,y(I)-deltxt, ...
            ['(',num2str(x(I),'%8.4f'),',',num2str(y(I),'%8.4f'),')'], ...
            'color','k','fontweight','bold');
        drawnow
    end


    %%% @Down - what happens when a mouse button is pressed
    function Down(varargin);
      xundo=[[x;0*(length(x)+1:Lmax)'],xundo(:,1:min([size(xundo,2),max_undo-1]))];
      yundo=[[y;0*(length(y)+1:Lmax)'],yundo(:,1:min([size(yundo,2),max_undo-1]))];
      Lundo=[L,Lundo(1:min([length(Lundo),max_undo-1]))];
      Iundo=[I,Iundo(1:min([length(Iundo),max_undo-1]))];
      p=get(a,'currentpoint');
      [V2 I]=min((x-p(1)).^2+(y-p(3)).^2);
      xx=x;
      yy=y;
      xx(I)=[];
      yy(I)=[];
      mindist2=min((xx-x(I)).^2+(yy-y(I)).^2);
      switch varargin{1}.SelectionType
        %%% Mouse left-click:
        case 'normal'
            %%% Add a knot if left-click is close to aerofoil contour:
            if V2>min(1e-4,mindist2)
                [xs ys] = splinefit([1;x;1],[0;y;0],1);
                ppk = 100; % needs to be the same in 'splinefit.m'
                [V2 Is]=min((xs-p(1)).^2+(ys-p(3)).^2);
                if V2<1e-4
                    xI=xs(Is);yI=ys(Is);                
                    I = ceil(Is/ppk);
                    L=L+1;
                    Lmax=max([L,Lmax]);
                    x(I+1:L)=x(I:end);
                    y(I+1:L)=y(I:end);
                    x(I)=xI;
                    y(I)=yI;
                    xundo=[xundo;0*(size(xundo,1)+1:Lmax)'*(1:size(xundo,2))];
                    yundo=[yundo;0*(size(yundo,1)+1:Lmax)'*(1:size(yundo,2))];
                    xredo=[];
                    yredo=[];
                    Lredo=[];
                    Iredo=[];
                    b=1;
                    plot_all(x,y);
                    
                end
            %%% Select a knot if left-click is close to it:
            else
                b=1;
                plot_all(x,y);
            end
        %%% Mouse right click:
        case 'alt'
            %%% Delete a knot if right-click is close to it:
            if V2<min([1e-4,mindist2])
                L=L-1;
                x=xx;
                y=yy;
                xredo=[];
                yredo=[];
                Lredo=[];
                Iredo=[];
                plot_all(x,y);
            end
      end
    end

    %%% @Up - what happens when a mouse button is released
    function Up(varargin);
        b=0;
    end

    %%% @Move - what happens when the mouse moves
    %%% (while holding the left button clicked for b=true)
    function Move(varargin)
        if b
            p=get(a,'currentpoint');
            x(I)=max([min([p(1),xmax]),xmin]);
            y(I)=max([min([p(3),ymax]),ymin]);
            xredo=[];
            yredo=[];
            plot_all(x,y);
        end
    end

    %%% @Key - the various keyboard options
    function Key(varargin);
        if ~delta;delta=mean(abs(diff(y)));end
        % to be done: if varargin{2}.Modifier=='control' 
        switch varargin{2}.Key
            %%% 'l' load a new .surf file
            case 'l'
                [filein,pathin]=uigetfile([pathin '*.surf']);
                y=load([pathin,filein]);
                x=y(2:end-1,1);
                y=y(2:end-1,2);
                L=length(x);
                I=(x-1).^2+y.^2; I=find(I==max(I)); I=I(1);
                Xbk=x;
                Ybk=y;
            %%% 's' save into a .surf file:
            case 's'
                dataout=[[1;x;1],[0;y;0]];
                [fileout,pathout]=uiputfile([pathin '*.surf']);
                save([pathout fileout],'dataout','-ascii')
            %%% 'b' backup configuration
            case 'b'
                Xbk=x;
                Ybk=y;
                disp('knot position backed up')
            %%% 't' restore last backup
            case 't'
                x=Xbk;
                y=Ybk;
                L=length(x);
                I=1;
                disp('knot position restored')
            %%% 'u' undo last action
            case 'u'
                if isempty(xundo)
                    disp('undo max reached')
                else
                    Lredo=[L,Lredo(1:min([length(Lredo),max_undo-1]))];
                    Iredo=[I,Iredo(1:min([length(Iredo),max_undo-1]))];
                    xredo=[[x;0*(length(x)+1:Lmax)'],xredo(:,1:min([size(xredo,2),max_undo-1]))];
                    yredo=[[y;0*(length(y)+1:Lmax)'],yredo(:,1:min([size(yredo,2),max_undo-1]))];
                    L=Lundo(1);
                    I=Iundo(1);
                    x=xundo(1:L,1);
                    y=yundo(1:L,1);
                    Lundo=Lundo(2:end);
                    Iundo=Iundo(2:end);
                    xundo=xundo(:,2:end);
                    yundo=yundo(:,2:end);
                end
            %%% 'r' redo - cancel last undo    
            case 'r'
                if isempty(xredo)
                    disp('last action reached')
                else
                    Lundo=[L,Lundo(1:min([length(Lundo),max_undo-1]))];
                    Iundo=[I,Iundo(1:min([length(Iundo),max_undo-1]))];
                    xundo=[[x;0*(length(x)+1:Lmax)'],xundo(:,1:min([size(xundo,2),max_undo-1]))];
                    yundo=[[y;0*(length(x)+1:Lmax)'],yundo(:,1:min([size(yundo,2),max_undo-1]))];
                    L=Lredo(1);
                    I=Iredo(1);
                    x=xredo(1:L,1);
                    y=yredo(1:L,1);
                    Lredo=Lredo(2:end);
                    Iredo=Iredo(2:end);
                    xredo=xredo(:,2:end);
                    yredo=yredo(:,2:end);
                end
            %%% 'z' zoomed view   
            case 'z'
                p=get(a,'currentpoint');
                axisZ=[p(1)-.05 p(1)+.05 p(3)-.03 p(3)+.03];
                try delete(t);end;
                set(h,'WindowKeyPressFcn',@emptyFunctionHandle,...
                    'windowbuttondownfcn',@emptyFunctionHandle,...
                    'WindowButtonMotionFcn',@emptyFunctionHandle,...
                    'WindowButtonUpFcn',@emptyFunctionHandle)
                hZ=figure('units','normalized',...
                    'outerposition',[.3 .3 1.05*Res(4)/Res(3) .7],...
                    'DockControls','off',...
                    'MenuBar','none',...
                    'name','zoomed view',...
                    'NumberTitle','off',...
                    'WindowKeyPressFcn',@KeyZ,...
                    'windowbuttondownfcn',@DownZ,...
                    'WindowButtonMotionFcn',@MoveZ,...
                    'WindowButtonUpFcn',@UpZ,...
                    'DeleteFcn',@figDeleteZ);
                aZ=axes('position',[.10,.10,.87,.87]);
                plot(xs,ys,'k', ...
                     [1;x],[0;y],'.k', ...
                     x(I),y(I),'xk','markersize',13)
                plot_curvature(xs,ys);
                axis equal
                axis(axisZ)
                drawnow
            %%% press 'd' to change the rate of displacement of a knot
            %%% when using the arrow keys instead of holding left mouse
            %%% button
            case 'd'
                delta=str2double(inputdlg('enter delta'));
                deltaZ=.2*delta;

            case 'c'
                if c==0
                    
                    c = 1;
                else
                    c = 0;
                end

            case 'f'
                if full==0
                    full = 1;
                else
                    full = 0;
                end

            case 'p'
                pathin=[pwd,'/Geometry/'];
                [filein,pathin]=uigetfile([pathin '*.surf']);
                y_ref=load([pathin,filein]);
                x_ref=y_ref(2:end-1,1);
                y_ref=y_ref(2:end-1,2);
                has_ref = 1;
                show_ref = 1;

            case 'q'
                if has_ref==1 && show_ref == 0
                    show_ref = 1;
                else
                    show_ref = 0;
                end

            case 'm'
                % Ensure inputs are column vectors before smoothing
                x = x(:);
                y = y(:);

                % Smoothing tolerance – smaller = closer fit, larger = smoother
                % Start with a moderate value (adjust as needed)
                tol = 1e-6 * length(x) * var(y);

                try
                    % spaps returns a spline structure; evaluate at original x
                    spl = spaps(x, y, tol);
                    yy_smoothed = fnval(spl, x);

                    % Force smoothed y to be a column vector
                    y = yy_smoothed(:);
                catch
                    % Fallback to loess if spaps fails
                    warning('spaps failed, using loess smoothing.');
                    span = 0.5;
                    y = smoothdata(y, 'loess', span);
                    y = y(:);
                end

                % x remains the same, but ensure it's a column
                x = x(:);
                L = length(x);          % update number of points

                % Recompute I (index of trailing edge point – x closest to 1)
                [~, I] = min((x-1).^2 + y.^2);

                % Redraw airfoil
                [xs, ys] = splinefit([1; x; 1], [0; y; 0], 0);
                set(0, 'CurrentFigure', h)
                try delete(t); end
                plot(xs, ys, 'k', [1; x], [0; y], '.k', x(I), y(I), 'xk', 'markersize', 13)
                plot_curvature(xs,ys);
                axis equal; axis([0 1 -.2 .2])
                t = text(x(I)+deltxt, y(I)-deltxt, ...
                    sprintf('(%8.4f,%8.4f)', x(I), y(I)), ...
                    'color','k','fontweight','bold');
                drawnow

                % Push onto undo stack
                xundo = [[x; zeros(Lmax-length(x),1)], xundo(:,1:min(end,max_undo-1))];
                yundo = [[y; zeros(Lmax-length(y),1)], yundo(:,1:min(end,max_undo-1))];
                Lundo = [L, Lundo(1:min(end,max_undo-1))];
                Iundo = [I, Iundo(1:min(end,max_undo-1))];
                xredo = []; yredo = []; Lredo = []; Iredo = [];


            case 'leftarrow'
                x(I)=max([x(I)-delta,xmin]);
            case 'rightarrow'
                x(I)=min([x(I)+delta,xmax]);
            case 'downarrow'
                y(I)=max([y(I)-delta,ymin]);
            case 'uparrow'
                y(I)=min([y(I)+delta,ymax]);
        end
        set(0, 'CurrentFigure', h)
        plot_all(x,y);
    end


    %%%%%%%%%%%%%% FUNCTIONS FOR ZOOMED FIGURE %%%%%%%%%%%%%%
    %%% @Down - what happens when a mouse button is pressed
    function DownZ(varargin);
      xundo=[[x;0*(length(x)+1:Lmax)'],xundo(:,1:min([size(xundo,2),max_undo-1]))];
      yundo=[[y;0*(length(y)+1:Lmax)'],yundo(:,1:min([size(yundo,2),max_undo-1]))];
      Lundo=[L,Lundo(1:min([length(Lundo),max_undo-1]))];
      Iundo=[I,Iundo(1:min([length(Iundo),max_undo-1]))];
      p=get(aZ,'currentpoint');
      [V2 I]=min((x-p(1)).^2+(y-p(3)).^2);
      xx=x;
      yy=y;
      xx(I)=[];
      yy(I)=[];
      mindist2=min((xx-x(I)).^2+(yy-y(I)).^2);
      switch varargin{1}.SelectionType
        %%% Mouse left-click:
        case 'normal'
            %%% Add a knot if left-click is close to aerofoil contour:
            if V2>min(1e-6,mindist2)
                [xs ys] = splinefit([1;x;1],[0;y;0],1);
                ppk = 100; % needs to be the same in 'splinefit.m'
                [V2 Is]=min((xs-p(1)).^2+(ys-p(3)).^2);
                if V2<1e-6
                    xI=xs(Is);yI=ys(Is);                
                    I = ceil(Is/ppk);
                    L=L+1;
                    Lmax=max([L,Lmax]);
                    x(I+1:L)=x(I:end);
                    y(I+1:L)=y(I:end);
                    x(I)=xI;
                    y(I)=yI;
                    xundo=[xundo;0*(size(xundo,1)+1:Lmax)'*(1:size(xundo,2))];
                    yundo=[yundo;0*(size(yundo,1)+1:Lmax)'*(1:size(yundo,2))];
                    xredo=[];
                    yredo=[];
                    b=1;
                    set(0, 'CurrentFigure', h)
                    plot_all(x,y);
                    %drawnow
                    figure(hZ)
                    try delete(t);end;
                    plot(xs,ys,'k', ...
                         [1;x],[0;y],'.k', ...
                         x(I),y(I),'xk', ...
                         'markersize',13);
                    plot_curvature(xs,ys);
                    axis equal
                    axis(axisZ)
                    t=text(x(I)+deltxtZ,y(I)-deltxtZ, ...
                           ['(',num2str(x(I),'%8.4f'),',',num2str(y(I),'%8.4f'),')'], ...
                           'color','k','fontweight','bold');
                    drawnow
                end                
            %%% Select a knot if left-click is close to it:
            else
                b=1;
                set(0, 'CurrentFigure', h)
                plot_all(x,y);
                %drawnow
                figure(hZ)
                try delete(t);end;
                plot(xs,ys,'k', ...
                     [1;x],[0;y],'.k', ...
                     x(I),y(I),'xk', ...
                     'markersize',13);
                plot_curvature(xs,ys);
                axis equal
                axis(axisZ)
                t=text(x(I)+deltxtZ,y(I)-deltxtZ, ...
                       ['(',num2str(x(I),'%8.4f'),',',num2str(y(I),'%8.4f'),')'], ...
                       'color','k','fontweight','bold');
                drawnow
            end
        %%% Mouse right click:
        case 'alt'
            %%% Delete a knot if right-click is close to it:
            if V2<min([1e-6,mindist2])
                L=L-1;
                x=xx;
                y=yy;
                xredo=[];
                yredo=[];
                set(0, 'CurrentFigure', h)
                plot_all(x,y);
                %drawnow
                figure(hZ)
                try delete(t);end;
                plot(xs,ys,'k', ...
                     [1;x],[0;y],'.k', ...
                     'markersize',13);
                plot_curvature(xs,ys);
                axis equal
                axis(axisZ)
                drawnow
            end
      end
    end

    %%% @Up - what happens when a mouse button is released
    function UpZ(varargin);
        b=0;
    end

    %%% @Move - what happens when the mouse moves
    %%% (while holding the left button clicked for b=true)
    function MoveZ(varargin)
        p=get(aZ,'currentpoint');
        if b
            x(I)=max([min([p(1),xmax]),xmin]);
            y(I)=max([min([p(3),ymax]),ymin]);
            xredo=[];
            yredo=[];
            set(0, 'CurrentFigure', h)
            plot_all(x,y);
            %drawnow
            set(0, 'CurrentFigure', hZ)
            try delete(t);end;
            plot(xs,ys,'k', ...
                 [1;x],[0;y],'.k', ...
                 x(I),y(I),'xk', ...
                 'markersize',13);
            plot_curvature(xs,ys);
            axis equal
            axis(axisZ)
            t=text(x(I)+deltxtZ,y(I)-deltxtZ, ...
                       ['(',num2str(x(I),'%8.4f'),',',num2str(y(I),'%8.4f'),')'], ...
                       'color','k','fontweight','bold');
            drawnow
        end
    end

    %%% @Key - the various keyboard options
    function KeyZ(varargin);
        if ~delta;delta=mean(abs(diff(y)));end
        % to be done: if varargin{2}.Modifier=='control' 
        switch varargin{2}.Key
            %%% 'u' undo last action
            case 'u'
                if isempty(xundo)
                    disp('undo max reached')
                else
                    Lredo=[L,Lredo(1:min([length(Lredo),max_undo-1]))];
                    Iredo=[I,Iredo(1:min([length(Iredo),max_undo-1]))];
                    xredo=[[x;0*(length(x)+1:Lmax)'],xredo(:,1:min([size(xredo,2),max_undo-1]))];
                    yredo=[[y;0*(length(y)+1:Lmax)'],yredo(:,1:min([size(yredo,2),max_undo-1]))];
                    L=Lundo(1);
                    I=Iundo(min([length(Iundo),2]));
                    x=xundo(1:L,1);
                    y=yundo(1:L,1);
                    Lundo=Lundo(2:end);
                    Iundo=Iundo(2:end);
                    xundo=xundo(:,2:end);
                    yundo=yundo(:,2:end);
                end
            %%% 'r' redo - cancel last undo    
            case 'r'
                if isempty(xredo)
                    disp('last action reached')
                else
                    Lundo=[L,Lundo(1:min([length(Lundo),max_undo-1]))];
                    Iundo=[I,Iundo(1:min([length(Iundo),max_undo-1]))];
                    xundo=[[x;0*(length(x)+1:Lmax)'],xundo(:,1:min([size(xundo,2),max_undo-1]))];
                    yundo=[[y;0*(length(x)+1:Lmax)'],yundo(:,1:min([size(yundo,2),max_undo-1]))];
                    L=Lredo(1);
                    I=Iredo(1);
                    x=xredo(1:L,1);
                    y=yredo(1:L,1);
                    Lredo=Lredo(2:end);
                    Iredo=Iredo(2:end);
                    xredo=xredo(:,2:end);
                    yredo=yredo(:,2:end);
                end
            case 'z'
                close(hZ)
                set(h,'WindowKeyPressFcn',@Key,...
                      'windowbuttondownfcn',@Down,...
                      'WindowButtonMotionFcn',@Move,...
                      'WindowButtonUpFcn',@Up)
                return
            %%% press 'd' to change the rate of displacement of a knot
            %%% when using the arrow keys instead of holding left mouse
            %%% button
            case 'd'
                delta=str2double(inputdlg('enter delta'));
                deltaZ=.2*delta;
            case 'leftarrow'
                x(I)=max([x(I)-delta,xmin]);
            case 'rightarrow'
                x(I)=min([x(I)+delta,xmax]);
            case 'downarrow'
                y(I)=max([y(I)-delta,ymin]);
            case 'uparrow'
                y(I)=min([y(I)+delta,ymax]);
        end
        if I<1
            I=1;
        elseif I>L
            I=L;
        end
        set(0, 'CurrentFigure', h)
        plot_all(x,y);
        %drawnow
        set(0, 'CurrentFigure', hZ)
        try delete(t);end;
        plot(xs,ys,'k', ...
             [1;x],[0;y],'.k', ...
             x(I),y(I),'xk', ...
             'markersize',13);
        plot_curvature(xs,ys);
        axis equal
        axis(axisZ)
        t=text(x(I)+deltxtZ,y(I)-deltxtZ, ...
                   ['(',num2str(x(I),'%8.4f'),',',num2str(y(I),'%8.4f'),')'], ...
                   'color','k','fontweight','bold');
        drawnow
    end

    function figDelete(varargin)
        try close(hZ);end;
    end

    function figDeleteZ(varargin)
        set(h,'WindowKeyPressFcn',@Key,...
              'Windowbuttondownfcn',@Down,...
              'WindowButtonMotionFcn',@Move,...
              'WindowButtonUpFcn',@Up)
        return
    end

    %%%% empty function to make figure 'h' inactive while 'hZ' is active
    function emptyFunctionHandle(varargin)
    end

end
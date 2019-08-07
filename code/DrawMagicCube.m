function DrawMagicCube(varargin)
%% DRAWMAGICCUBE - Draw the magic cube
%
%   DrawMagicCube(MagicCube)
%   DrawMagicCube(ax, ...)
%
%   MagicCube:
%       'Param': 
%           'Order': integer
%           'Size': integer
%           'Draw3d': bool
%       'Block': {top, bottom, left, right, front, back}
%           'Color': Order by Order cell
%           'Finish': bool
%
%   mode: 'Cube', 'Plane'

%% Check the number of parameters
narginchk(1,2);
nargoutchk(0,0);

%% Check the input parameters
% option
if nargin == 3
    ax = varargin{1};
    MagicCube = varargin{2};
else
    MagicCube = varargin{1};
    ax = gca;
end

%% Set axes
axes(ax);
cla;
axis equal;
axis off;

%% Draw the magic cube
order = MagicCube.Param.Order;
size = MagicCube.Param.Size;
Draw3d = MagicCube.Param.Draw3d;
if Draw3d
    % front 
    for i = 1:order
        for j = 1:order
            x = [order, order, order, order] * size;
            y = [j - 1, j, j, j - 1] * size;
            z = [i - 1, i - 1, i, i] * size;
            patch(x, y, z, MagicCube.Block.front.Color{order + 1 - i, j}, 'LineWidth', 2);      
        end
    end
    % top  
    for i = 1:order
        for j = 1:order
            x = [i - 1, i - 1, i, i] * size;
            y = [j - 1, j, j, j - 1] * size;
            z = [order, order, order, order] * size;
            patch(x, y, z, MagicCube.Block.top.Color{i, j}, 'LineWidth', 2);      
        end
    end
    % right  
    for i = 1:order
        for j = 1:order
            x = [j - 1, j, j, j - 1] * size;
            y = [order, order, order, order] * size;
            z = [i - 1, i - 1, i, i] * size;
            patch(x, y, z, MagicCube.Block.right.Color{order + 1 - i, order + 1 - j}, 'LineWidth', 2);     
        end
    end
    view(135, 30);
else
    % left 
    for i = 1:order
        for j = 1:order
            x = [j - 1, j, j, j - 1] * size;
            y = [i - 1, i - 1, i, i] * size + size * order;
            patch(x, y, MagicCube.Block.left.Color{order + 1 - i, j}, 'LineWidth', 2);      
        end
    end
    % front  
    for i = 1:order
        for j = 1:order
            x = [j - 1, j, j, j - 1] * size + size * order;
            y = [i - 1, i - 1, i, i] * size + size * order;
            patch(x, y, MagicCube.Block.front.Color{order + 1 - i, j}, 'LineWidth', 2);      
        end
    end
    % right  
    for i = 1:order
        for j = 1:order
            x = [j - 1, j, j, j - 1] * size + size * order * 2;
            y = [i - 1, i - 1, i, i] * size + size * order;
            patch(x, y, MagicCube.Block.right.Color{order + 1 - i, j}, 'LineWidth', 2);     
        end
    end
    % back  
    for i = 1:order
        for j = 1:order
            x = [j - 1, j, j, j - 1] * size + size * order * 3;
            y = [i - 1, i - 1, i, i] * size + size * order;
            patch(x, y, MagicCube.Block.back.Color{order + 1 - i, j}, 'LineWidth', 2);     
        end
    end   
    % top  
    for i = 1:order
        for j = 1:order
            x = [j - 1, j, j, j - 1] * size + size * order;
            y = [i - 1, i - 1, i, i] * size + size * order * 2;
            patch(x, y, MagicCube.Block.top.Color{order + 1 - i, j}, 'LineWidth', 2);     
        end
    end 
    % bottom  
    for i = 1:order
        for j = 1:order
            x = [j - 1, j, j, j - 1] * size + size * order;
            y = [i - 1, i - 1, i, i] * size;
            patch(x, y, MagicCube.Block.bottom.Color{order + 1 - i, j}, 'LineWidth', 2);     
        end
    end 
end



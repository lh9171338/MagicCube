function MagicCube = RotateMagicCube(MagicCube, Rotate)
%% ROTATEMAGICCUBE - Rotate the magic cube
%
%   MagicCube = RotateMagicCube(MagicCube, Rotate)
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
%   Rotate:
%       'Direction': 'U' / 'D' / 'L' / 'R' / 'C' / 'A'
%       'Index': 1~Order / 0(all)

%% Check the number of parameters
narginchk(2,2);
nargoutchk(1,1);

%% Rotate the magic cube
order = MagicCube.Param.Order;
direction = Rotate.Direction;
index = Rotate.Index;
if index == 0
    index = 1:order;
end
switch direction
    case 'U'
        temp = MagicCube.Block.front.Color(:, index);
        MagicCube.Block.front.Color(:, index) = MagicCube.Block.bottom.Color(:, index);
        MagicCube.Block.bottom.Color(:, index) = MagicCube.Block.back.Color(end:-1:1, order + 1 - index);
        MagicCube.Block.back.Color(end:-1:1, order + 1 - index) = MagicCube.Block.top.Color(:, index);
        MagicCube.Block.top.Color(:, index) = temp;
        if any(index == 1)
            MagicCube.Block.left.Color = rot90(MagicCube.Block.left.Color, 1);
        end
        if any(index == order)
            MagicCube.Block.right.Color = rot90(MagicCube.Block.right.Color, 3);
        end        
    case 'D'
        temp = MagicCube.Block.front.Color(:, index);
        MagicCube.Block.front.Color(:, index) = MagicCube.Block.top.Color(:, index);
        MagicCube.Block.top.Color(:, index) = MagicCube.Block.back.Color(end:-1:1, order + 1 - index);
        MagicCube.Block.back.Color(end:-1:1, order + 1 - index) = MagicCube.Block.bottom.Color(:, index);
        MagicCube.Block.bottom.Color(:, index) = temp; 
        if any(index == 1)
            MagicCube.Block.left.Color = rot90(MagicCube.Block.left.Color, 3);
        end
        if any(index == order)
            MagicCube.Block.right.Color = rot90(MagicCube.Block.right.Color, 1);
        end  
    case 'L'
        temp = MagicCube.Block.front.Color(index, :);
        MagicCube.Block.front.Color(index, :) = MagicCube.Block.right.Color(index, :);
        MagicCube.Block.right.Color(index, :) = MagicCube.Block.back.Color(index, :);
        MagicCube.Block.back.Color(index, :) = MagicCube.Block.left.Color(index, :);
        MagicCube.Block.left.Color(index, :) = temp; 
        if any(index == 1)
            MagicCube.Block.top.Color = rot90(MagicCube.Block.top.Color, 3);
        end
        if any(index == order)
            MagicCube.Block.bottom.Color = rot90(MagicCube.Block.bottom.Color, 1);
        end  
    case 'R'
        temp = MagicCube.Block.front.Color(index, :);
        MagicCube.Block.front.Color(index, :) = MagicCube.Block.left.Color(index, :);
        MagicCube.Block.left.Color(index, :) = MagicCube.Block.back.Color(index, :);
        MagicCube.Block.back.Color(index, :) = MagicCube.Block.right.Color(index, :);
        MagicCube.Block.right.Color(index, :) = temp;  
        if any(index == 1)
            MagicCube.Block.top.Color = rot90(MagicCube.Block.top.Color, 1);
        end
        if any(index == order)
            MagicCube.Block.bottom.Color = rot90(MagicCube.Block.bottom.Color, 3);
        end
    case 'C'
        MagicCube = RotateMagicCube(MagicCube, struct('Direction', 'L', 'Index', 0));
        MagicCube = RotateMagicCube(MagicCube, struct('Direction', 'D', 'Index', index));
        MagicCube = RotateMagicCube(MagicCube, struct('Direction', 'R', 'Index', 0));
    case 'A'
        MagicCube = RotateMagicCube(MagicCube, struct('Direction', 'L', 'Index', 0));
        MagicCube = RotateMagicCube(MagicCube, struct('Direction', 'U', 'Index', index));
        MagicCube = RotateMagicCube(MagicCube, struct('Direction', 'R', 'Index', 0));
end

%% Check whether finish
MagicCube.Block.top.Finish = all(all(strcmp(MagicCube.Block.top.Color, MagicCube.Block.top.Color{1, 1})));
MagicCube.Block.bottom.Finish = all(all(strcmp(MagicCube.Block.bottom.Color, MagicCube.Block.bottom.Color{1, 1})));
MagicCube.Block.left.Finish = all(all(strcmp(MagicCube.Block.left.Color, MagicCube.Block.left.Color{1, 1})));
MagicCube.Block.right.Finish = all(all(strcmp(MagicCube.Block.right.Color, MagicCube.Block.right.Color{1, 1})));
MagicCube.Block.front.Finish = all(all(strcmp(MagicCube.Block.front.Color, MagicCube.Block.front.Color{1, 1})));
MagicCube.Block.back.Finish = all(all(strcmp(MagicCube.Block.back.Color, MagicCube.Block.back.Color{1, 1})));
MagicCube.Block.Finish = MagicCube.Block.top.Finish && MagicCube.Block.bottom.Finish && MagicCube.Block.left.Finish ...
    && MagicCube.Block.right.Finish && MagicCube.Block.front.Finish && MagicCube.Block.back.Finish;


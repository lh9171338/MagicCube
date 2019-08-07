function MagicCube = InitMagicCube(option)
%% INITMAGICCUBE - Initial the magic cube
%
%   MagicCube = InitMagicCube()
%   MagicCube = InitMagicCube(option)
%
%   option: 
%       'Order': integer, default(3)
%       'Size': integer, default(20)
%       'Draw3d': bool
%       'Iter': integer
%
%   MagicCube:
%       'Param': 
%           'Order': integer
%           'Size': integer
%           'Draw3d': bool
%       'Block': {top, bottom, left, right, front, back}
%           'Color': Order by Order cell
%           'Finish': bool

%% Check the number of parameters
narginchk(0,1);
nargoutchk(1,1);

%% Check the input parameters
% option
if nargin < 1
    option = struct('Order', 3, 'Size', 20, 'Draw3d', true, 'Iter', 20);
end

%% Initial the magic cube
order = option.Order;
size = option.Size;
Draw3d = option.Draw3d;
MagicCube.Param.Order = order;
MagicCube.Param.Size = size;
MagicCube.Param.Draw3d = Draw3d;
MagicCube.Block.top.Color = repmat({'yellow'}, order, order);
MagicCube.Block.bottom.Color = repmat({'white'}, order, order);
MagicCube.Block.left.Color = repmat({'cyan'}, order, order);
MagicCube.Block.right.Color = repmat({'red'}, order, order);
MagicCube.Block.front.Color = repmat({'blue'}, order, order);
MagicCube.Block.back.Color = repmat({'green'}, order, order);
MagicCube.Block.top.Finish = true;
MagicCube.Block.bottom.Finish = true;
MagicCube.Block.left.Finish = true;
MagicCube.Block.right.Finish = true;
MagicCube.Block.front.Finish = true;
MagicCube.Block.back.Finish = true;
MagicCube.Block.Finish = true;

%% Make the magic cube disorder
iter = option.Iter;
for i=1:iter
    ndirection = floor(rand * 6);
    index = mod(floor(rand * 4), 4);
    switch ndirection
        case {0, 6}
            direction = 'U';
        case 1
            direction = 'D';
        case 2
            direction = 'L';
        case 3
            direction = 'R';
        case 4
            direction = 'C';
        case 5
            direction = 'A';
    end
    Rotate.Direction = direction;
    Rotate.Index = index;
    MagicCube = RotateMagicCube(MagicCube, Rotate);
end




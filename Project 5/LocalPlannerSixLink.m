function out = LocalPlannerSixLink (x1, x2, obstacle)
% Generate a random freespace configuration for the robot

diff = x2 - x1;

t = diff > 180;
diff(t) = diff(t) - 360;

t = diff < -180;
diff(t) = diff(t) + 360;

samp = ceil(sum(abs(diff)) / 10);

for i = 1:samp
    
    x = mod(x1 + (i/samp)*diff, 360);
    
    config = SixLinkRobot (x);
    
    if (CollisionCheck(config, obstacle))
        out = false;
        return
    end
end

out = true;

function ProjectedPoint = pointProjection(point, constraints)
%POINTPROJECTION projects a point (x,y) according to its constrains
%   Detailed explanation goes here
    ProjectedPoint = NaN(1,2);
    if point(1) < constraints(1,1)
        ProjectedPoint(1) = constraints(1,1);
    elseif point(1) > constraints(1,2)
        ProjectedPoint(1) = constraints(1,2);
    else
        ProjectedPoint(1) = point(1);
    end
    
    if point(2) < constraints(2,1)
        ProjectedPoint(2) = constraints(2,1);
    elseif point(2) > constraints(2,2)
        ProjectedPoint(2) = constraints(2,2);
    else
        ProjectedPoint(2) = point(2);
    end
    
end


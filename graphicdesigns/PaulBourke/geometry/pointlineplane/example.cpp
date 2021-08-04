////////////////////////////////////////////////////////////////////////////////
// 
// 2D Line Segment Intersection example
// Implementation of the theory provided by Paul Bourke
// 
// Written by Damian Coventry
// Tuesday, 9 January 2007
// 
////////////////////////////////////////////////////////////////////////////////

#include <iostream>

class Vector
{
public:
    float x_, y_;

    Vector(float f = 0.0f)
        : x_(f), y_(f) {}

    Vector(float x, float y)
        : x_(x), y_(y) {}
};

class LineSegment
{
public:
    Vector begin_;
    Vector end_;

    LineSegment(const Vector& begin, const Vector& end)
        : begin_(begin), end_(end) {}

    enum IntersectResult { PARALLEL, COINCIDENT, NOT_INTERESECTING, INTERESECTING };

    IntersectResult Intersect(const LineSegment& other_line, Vector& intersection)
    {
        float denom = ((other_line.end_.y_ - other_line.begin_.y_)*(end_.x_ - begin_.x_)) -
                      ((other_line.end_.x_ - other_line.begin_.x_)*(end_.y_ - begin_.y_));

        float nume_a = ((other_line.end_.x_ - other_line.begin_.x_)*(begin_.y_ - other_line.begin_.y_)) -
                       ((other_line.end_.y_ - other_line.begin_.y_)*(begin_.x_ - other_line.begin_.x_));

        float nume_b = ((end_.x_ - begin_.x_)*(begin_.y_ - other_line.begin_.y_)) -
                       ((end_.y_ - begin_.y_)*(begin_.x_ - other_line.begin_.x_));

        if(denom == 0.0f)
        {
            if(nume_a == 0.0f && nume_b == 0.0f)
            {
                return COINCIDENT;
            }
            return PARALLEL;
        }

        float ua = nume_a / denom;
        float ub = nume_b / denom;

        if(ua >= 0.0f && ua <= 1.0f && ub >= 0.0f && ub <= 1.0f)
        {
            // Get the intersection point.
            intersection.x_ = begin_.x_ + ua*(end_.x_ - begin_.x_);
            intersection.y_ = begin_.y_ + ua*(end_.y_ - begin_.y_);

            return INTERESECTING;
        }

        return NOT_INTERESECTING;
    }
};

void DoLineSegmentIntersection(const Vector& p0, const Vector& p1, const Vector& p2, const Vector& p3)
{
    LineSegment linesegment0(p0, p1);
    LineSegment linesegment1(p2, p3);

    Vector intersection;

    std::cout << "Line Segment 0: (" << p0.x_ << ", " << p0.y_ << ") to (" << p1.x_ << ", " << p1.y_ << ")\n"
              << "Line Segment 1: (" << p2.x_ << ", " << p2.y_ << ") to (" << p3.x_ << ", " << p3.y_ << ")\n";

    switch(linesegment0.Intersect(linesegment1, intersection))
    {
    case LineSegment::PARALLEL:
        std::cout << "The lines are parallel\n\n";
        break;
    case LineSegment::COINCIDENT:
        std::cout << "The lines are coincident\n\n";
        break;
    case LineSegment::NOT_INTERESECTING:
        std::cout << "The lines do not intersect\n\n";
        break;
    case LineSegment::INTERESECTING:
        std::cout << "The lines intersect at (" << intersection.x_ << ", " << intersection.y_ << ")\n\n";
        break;
    }
}

void main()
{
    DoLineSegmentIntersection(Vector(0.0f, 0.0f), Vector(5.0f, 5.0f), Vector(5.0f, 0.0f), Vector(0.0f, 5.0f));
    DoLineSegmentIntersection(Vector(1.0f, 3.0f), Vector(9.0f, 3.0f), Vector(0.0f, 1.0f), Vector(2.0f, 1.0f));
    DoLineSegmentIntersection(Vector(1.0f, 5.0f), Vector(6.0f, 8.0f), Vector(0.5f, 3.0f), Vector(6.0f, 4.0f));
    DoLineSegmentIntersection(Vector(1.0f, 1.0f), Vector(3.0f, 8.0f), Vector(0.5f, 2.0f), Vector(4.0f, 7.0f));
    DoLineSegmentIntersection(Vector(1.0f, 2.0f), Vector(3.0f, 6.0f), Vector(2.0f, 4.0f), Vector(4.0f, 8.0f));
    DoLineSegmentIntersection(Vector(3.5f, 9.0f), Vector(3.5f, 0.5f), Vector(3.0f, 1.0f), Vector(9.0f, 1.0f));
    DoLineSegmentIntersection(Vector(2.0f, 3.0f), Vector(7.0f, 9.0f), Vector(1.0f, 2.0f), Vector(5.0f, 7.0f));
}

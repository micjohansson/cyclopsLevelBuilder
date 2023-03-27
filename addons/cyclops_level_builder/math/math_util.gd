# MIT License
#
# Copyright (c) 2023 Mark McKay
# https://github.com/blackears/cyclopsLevelBuilder
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

@tool
extends Node
class_name  MathUtil

enum Axis { X, Y, Z }

static func snap_to_grid(pos:Vector3, cell_size:float)->Vector3:
#	return floor(pos / cell_size) * cell_size
	return floor((pos + Vector3(cell_size, cell_size, cell_size) / 2) / cell_size) * cell_size

#Returns intersection of line with point.  
# plane_perp_dir points in direction of plane's normal and does not need to be normalized
static func intersect_plane(ray_origin:Vector3, ray_dir:Vector3, plane_origin:Vector3, plane_perp_dir:Vector3)->Vector3:
	var s:float = (plane_origin - ray_origin).dot(plane_perp_dir) / ray_dir.dot(plane_perp_dir)
	return ray_origin + ray_dir * s

#Returns the closest point on the line to the ray
static func closest_point_on_line(ray_origin:Vector3, ray_dir:Vector3, line_origin:Vector3, line_dir:Vector3)->Vector3:
	var a:Vector3 = ray_dir.cross(line_dir)
	var w_perp:Vector3 = ray_dir.cross(a)
	return intersect_plane(line_origin, line_dir, ray_origin, w_perp)

static func trianglate_face(points:PackedVector3Array, normal:Vector3)->PackedVector3Array:
	var result:PackedVector3Array
	
	while (points.size() >= 3):
		var num_points:int = points.size()
		for i in range(0, num_points):
			var p0:Vector3 = points[i]
			var p1:Vector3 = points[wrap(i + 1, 0, num_points)]
			var p2:Vector3 = points[wrap(i + 2, 0, num_points)]
		
			#Godot uses clockwise winding
			var tri_norm_dir:Vector3 = (p2 - p0).cross(p1 - p0)
			if tri_norm_dir.dot(normal) > 0:
				result.append(p0)
				result.append(p1)
				result.append(p2)
				
				points.remove_at(i + 1)
				break
	
	return result

#Returns the normal of a triangle with a length twice the area of the triangle
static func triangle_determinant(p0:Vector3, p1:Vector3, p2:Vector3)->Vector3:
	return (p1 - p0).cross(p2 - p0)

#Returns a vector pointing along the normal in the clockwise winding direction with a length equal to twice the area of the triangle
static func triangle_area_x2(p0:Vector3, p1:Vector3, p2:Vector3)->Vector3:
	return (p2 - p0).cross(p1 - p0)
	
#Returns a vector poitning along the normal in the clockwise winding direction with a lengh equal to twice the area of the face
static func face_area_x2(points:PackedVector3Array)->Vector3:
	var result:Vector3
	
	var p0:Vector3 = points[0]
	
	for i in range(1, points.size() - 1):
		var p1:Vector3 = points[i]
		var p2:Vector3 = points[i + 1]
		
		result += (p2 - p0).cross(p1 - p0)
	
	return result

static func snap_to_best_axis_normal(vector:Vector3)->Vector3:
	if abs(vector.x) > abs(vector.y) and abs(vector.x) > abs(vector.z):
		return Vector3(1, 0, 0) if vector.x > 0 else Vector3(-1, 0, 0)
	elif abs(vector.y) > abs(vector.z):
		return Vector3(0, 1, 0) if vector.y > 0 else Vector3(0, -1, 0)
	else:
		return Vector3(0, 0, 1) if vector.z > 0 else Vector3(0, 0, -1)

static func get_longest_axis(vector:Vector3)->Axis:
	if abs(vector.x) > abs(vector.y) and abs(vector.x) > abs(vector.z):
		return Axis.X
	elif abs(vector.y) > abs(vector.z):
		return Axis.Y
	else:
		return Axis.Z
		
static func calc_bounds(points:PackedVector3Array)->AABB:
	var result:AABB = AABB(points[0], Vector3.ZERO)
	for i in range(1, points.size()):
		result = result.expand(points[i])
	return result
		

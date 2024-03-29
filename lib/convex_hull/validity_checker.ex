defmodule ConvexHull.ValidityChecker do
  @moduledoc false
  # This module contains general validity checks that are relevant for all algorithms, this includes checking if enough points
  # were given to construct a convex hull, checking if all points have the same dimensions and checking if the points have a valid
  # amount of dimensions. A relevant runtime error is raised if any of the validity checks fail.

  # Return true if all checks pass without rasing errors.
  def is_valid?(points, max_dimensions \\ nil) do
    check_number_points(points)
    check_consistent_dimensions(points)
    check_max_dimensions(points, max_dimensions)

    true
  end

  # Returns true if there are atleast 3 points (the minimum requirement for creating a convex hull). Raises runtime error if not.
  defp check_number_points(points) do
    if length(points) < 3, do: raise "Cannot compute convex hull with less than 3 points."
  end

  # Returns true if all points have the same number of dimensions. Raises runtime error if not.
  defp check_consistent_dimensions(points) do
    num_dimensions = length(Tuple.to_list(List.first(points)))

    if Enum.any?(points, fn point -> length(Tuple.to_list(point)) != num_dimensions end) do
      raise "Inconsistent number of dimensions of the given points."
    end
  end

  # Returns true if the number of dimensions of the points does not exceed the max allowed number. Raises runtime error if not.
  defp check_max_dimensions(points, max_dimensions) do
    if max_dimensions != nil do
      if length(Tuple.to_list(List.first(points))) > max_dimensions do
        raise "This algorithm does not allow more than #{max_dimensions} dimensions."
      end
    end
  end
end

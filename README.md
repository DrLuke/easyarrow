# simplearrow

Simply plot arrows using a single command.

## Arguments
easyarrow(x1, x2, y1, y2, varargin)
x1,y1: Vector of starting points
x2,y2: Vector of ending points

##Examples:
Plot an arrow from (0,0) to (1,1)
```matlab
easyarrow([0], [1], [0], [1])
```

Plot multiple 3D-Arrows with a filled tip and a fixed size arrowhead
```matlab
easyarrow([0 30], [20 50], [10 10], [30 30], [0 10], [10 -20], 'absolutelength', 10, 'solid', 1)
```

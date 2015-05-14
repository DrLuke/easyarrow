# easyarrow

Easily plot single or multiple arrows using a single command.

## Arguments
### 2D-Arrows
`easyarrow(x1, x2, y1, y2, varargin)`
* `x1,y1`: Vector of starting points
* `x2,y2`: Vector of ending points

### 3D-Arrows
`easyarrow(x1, x2, y1, y2, z1, z2, varargin)`
* `x1,y1,z1`: Vector of starting points
* `x2,y2,z2`: Vector of ending points
`z2` is optional. If it is omitted, `z1` will be used as `z2` instead.

### Additional Parameters
* `solid`: `numeric` If non-zero, draw the arrowhead as a filled patch (default: `1`)
* `absolutelength`: `numeric` Absolute length of arrowhead. If this is zero, the length of the arrowhead will be relative to the length of the arrow. (default: `0`)
* `headlength`: `numeric` Ratio of arrowhead length to arrow length. Ignored if absolutelength is greater than zero. (default: `0.3`)
* `headwidth`: `numeric` Ratio of arrowhead width at the base to the length of the arrowhead. (default: `0.2`)
* `stemstyle`: `string` LineSpec input for the stem (default: `'k'`)
* `linewidth`: `numeric` Linewidth input for lines (default: `1`)
* `headstyle`: `string` LineSpec input for the head (default: `'k'`)

##Examples:
Plot an arrow from (0,0) to (1,1)
```matlab
easyarrow([0], [1], [0], [1])
```

Plot multiple 3D-Arrows with a filled tip and a fixed size arrowhead
```matlab
easyarrow([0 30], [20 50], [10 10], [30 30], [0 10], [10 -20], 'absolutelength', 10, 'solid', 1)
```

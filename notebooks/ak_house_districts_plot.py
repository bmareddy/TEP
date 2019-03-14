import numpy as np
import shapefile
import matplotlib.pyplot as plt
from shapely.geometry.polygon import Polygon
from matplotlib.collections import PatchCollection
from descartes import PolygonPatch

sf = shapefile.Reader("C:\\Users\\madhu\\Documents\\git\\TEP\\tep\\data\\raw\\2018\\AK\\2013-HD-ProclamationPlan\\2013ProclamationPlan.shp")
district_shapes = sf.shapes()

def plot_scatter_points(points):
    """
    plot boundaries of each shape using the points in the polygon
    """
    x, y = zip(*points)
    global ax
    ax.scatter(x, y)

fig, ax = plt.subplots(num=1, clear=True, figsize=(12,12))

districts_patch = []
for district_shape in district_shapes:
    plot_scatter_points(district_shape.points)
    poly = Polygon(district_shape.points)
    districts_patch.append(PolygonPatch(poly))

#ax.add_collection(PatchCollection(districts_patch))

# set subplot scale and show
ax.set_xlim(-2500000,2000000)
ax.set_ylim(250000,2500000)
plt.show()

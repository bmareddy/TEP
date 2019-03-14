import numpy as np
import shapefile
from pyproj import Proj, transform
from shapely.geometry.polygon import Polygon
from shapely.ops import transform as shapely_transform
from descartes import PolygonPatch
import matplotlib.pyplot as plt
from matplotlib.collections import PatchCollection
from mpl_toolkits.basemap import Basemap

sf = shapefile.Reader("C:\\Users\\madhu\\Documents\\git\\TEP\\tep\\data\\raw\\2018\\AK\\2013-HD-ProclamationPlan\\2013ProclamationPlan.shp")
district_shapes = sf.shapes()

def transform_projection(list_of_coordinates, source_reference, destination_reference="4326") :
    """
    transforms a list of coordinates (x, y tuples) from source projection to destination projection
    Destination is set to default EPSG 4326 which is WGS84
    """
    source_proj = Proj("+init=EPSG:" + source_reference)
    destination_proj = Proj("+init=EPSG:" + destination_reference)

    y, x = zip(*list_of_coordinates)
    transformed_y, transformed_x = transform(source_proj, destination_proj, y, x)

    return zip(transformed_x, transformed_y)

def plot_scatter_points(points):
    """
    plot boundaries of each shape using the points in the polygon
    """
    y, x = zip(*points)
    global mm
    mm_x, mm_y = mm(x, y)
    mm.scatter(mm_x, mm_y)

# plot the data on the map
fig, ax = plt.subplots(num=1, clear=True, figsize=(12,12))
mm = Basemap(resolution = 'i',
            projection='merc',
            ellps='WGS84',
            lat_0 = 60.789785, lon_0 = -145.996703,
            llcrnrlon = -169.49, llcrnrlat = 49.4, urcrnrlon = -116.4, urcrnrlat = 71.63)
water = 'lightskyblue'
earth = 'cornsilk'
coast = mm.drawcoastlines()
continents = mm.fillcontinents(color=earth, lake_color=water)
bound= mm.drawmapboundary(fill_color=water)
countries = mm.drawcountries()
#merid = mm.drawmeridians(np.arange(-180, 180, 2), labels=[False, False, False, True])
#parall = mm.drawparallels(np.arange(0, 80), labels=[True, True, False, False])
juneau_lon, juneau_lat = -134.4167, 58.3
x, y = mm(juneau_lon, juneau_lat)
juneau = mm.scatter(x, y, 80, label="Juneau", color='red', zorder=10)

# construct a collection of polygon patches from shape points
district_patches = []
for district_shape in district_shapes:
    transformed_points = transform_projection(district_shape.points, '3338')
    y, x = zip(*transformed_points)
    poly = Polygon(list(zip(x, y)))
    mpoly = shapely_transform(mm, poly)
    district_patches.append(PolygonPatch(mpoly))

ax.add_collection(PatchCollection(district_patches, match_original=True))
plt.show()
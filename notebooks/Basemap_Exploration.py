from mpl_toolkits.basemap import Basemap
import matplotlib.pyplot as plt
from matplotlib.collections import PatchCollection
#from matplotlib.patches import Polygon
from shapely.geometry.polygon import Polygon
from shapely.ops import transform
import numpy as np
from descartes import PolygonPatch


# Make the figure
fig = plt.figure()
ax = fig.add_subplot(111)

# Easiest way to make a basemap is to use the cylidrical projection and 
# define the bottom left lat/lon and top right lat/lon corners

# Map of Utah
bot_left_lat  =36.5
bot_left_lon  =-114.5
top_right_lat =42.5
top_right_lon = -108.5

# create the map object, m
m = Basemap(resolution='i', projection='merc', \
    llcrnrlon=bot_left_lon, llcrnrlat=bot_left_lat, \
    urcrnrlon=top_right_lon, urcrnrlat=top_right_lat)

# Note: You can define the resolution of the map you just created. Higher 
# resolutions take longer to create.
#    'c' - crude
#    'l' - low
#    'i' - intermediate
#    'h' - high
#    'f' - full

# Draw some map elements on the map
m.drawcoastlines()
m.drawstates()
m.drawcountries()
m.drawrivers(color='blue')

# # Drawing ArcGIS Basemap (only works with cylc projections??)
# # Examples of what each map looks like can be found here:
# # http://kbkb-wx-python.blogspot.com/2016/04/python-basemap-background-image-from.html
# maps = ['ESRI_Imagery_World_2D',    # 0
#         'ESRI_StreetMap_World_2D',  # 1
#         'NatGeo_World_Map',         # 2
#         'NGS_Topo_US_2D',           # 3
#         'Ocean_Basemap',            # 4
#         'USA_Topo_Maps',            # 5
#         'World_Imagery',            # 6
#         'World_Physical_Map',       # 7
#         'World_Shaded_Relief',      # 8
#         'World_Street_Map',         # 9
#         'World_Terrain_Base',       # 10
#         'World_Topo_Map'            # 11
#         ]
# #print "drawing image from arcGIS server...",
# #m.arcgisimage(service=maps[8], xpixels=1000, verbose=False)
# #print "...finished"

# Plot a scatter point at WBB on the map object
lon = -111.85
lat = 40.77
m_lon, m_lat = m(lon, lat)
m.scatter(m_lon,m_lat,c='r',s=150)

# Plot some wind barbs
lons = np.arange(-115,-100,.5)
lats = np.arange(33,48,.5)
u = np.arange(-5,10,.5)
v = np.arange(5,20,.5)
m_lons, m_lats = m(lons, lats)
m.barbs(m_lons, m_lats, u, v, color='fuchsia')

# Plot line between two points
# (can also use greatcircle function to be more accurate)
x = [-110, -112]
y = [40, 42]
m.plot(x, y, color='navy', lw=5)

# Fill two polygon shapes
patches = []
homeplate = np.array([[-114,38],[-113,37],[-112,38],[-112,40],[-114,40]])
poly = Polygon(homeplate)
mpoly = transform(m, poly)
patches.append(PolygonPatch(mpoly))
triangle = np.array([[-111,38],[-110,37],[-110,42]])
tri = Polygon(triangle)
mtri = transform(m, tri)
patches.append(PolygonPatch(mtri))
ax.add_collection(PatchCollection(patches, facecolor='lightgreen', edgecolor='k', linewidths=1.5))

# Plot shapefiles: see here: http://basemaptutorial.readthedocs.io/en/latest/shapefile.html

# Plot contours
# m.contour(lons2D, lats2D, values2D)  # contour lines
# m.contourf(lons2D, lats2D, values2D) # contour color filled, can specify a cmap

# Plot gridded data
# m.pcolormesh(lons2D, lats2D, values2D) # can specify a cmap

# Add plot title and other plot elements the normal way
plt.title('Map of Utah Basemap Example')
plt.xlabel('this is the x label')

plt.show()
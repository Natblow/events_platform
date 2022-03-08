const mapElement = document.getElementById('map');

mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
// console.log('token', mapboxgl.accessToken)
  var map = new mapboxgl.Map({
    container: 'map', // Container ID
    style: 'mapbox://styles/mapbox/streets-v11', // Map style to use
    center: [-73.631055, 45.481847], // Starting position [lng, lat]
    zoom: 10, // Starting zoom level
  });

const markers = JSON.parse(mapElement.dataset.markers);
  markers.forEach((marker) => {
    console.log(marker)
    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat])
      .setPopup(new mapboxgl.Popup({ offset: 25 })
        .setHTML(
          "<div class="+"link_popup"+" >"+
          "<a href=/events/"+ marker.id+">"+
            "<h4>"+ marker.title +"</h4>" +
            "<p>" + marker.address+"</p>" +
          "</a>" +
          "</div>"
        ))
        .addTo(map);
  });

  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0});

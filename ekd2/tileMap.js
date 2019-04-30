const fs = require('fs');
const util = require('util');

/* 质朴长存法  by lifesinger */
function pad(num, n) {
    var len = num.toString().length;
    while(len < n) {
        num = "0" + num;
        len++;
    }
    return num;
}
function export2TileMap(data) {
	let style = data[0]
	let width = data[1]
	let height = data[2]
	console.log('style: ' + style)
	console.log('width:', width, ', height:', height, ', size:', width * height, width * height / 9, width * height * 10 / 9 + 3)
	return {
		version: 1,
		// tiledversion: '1.1.6',
		type: 'map',
		nextobjectid: 1,
		orientation: 'orthogonal',
		renderorder: 'left-up',
		infinite: false,
		width: width,
		height: height,
		tilewidth: 16,
		tileheight: 16,
		layers: [{
			data: data.slice(3, 3 + width * height).map(v=>v+1),
			name: 'ground',
			type: 'tilelayer',
			opacity: 1,
			visible: true,
			x: 0,
			y: 0,
			width: width,
			height: height,
		}],
		tilesets:[{
			firstgid: 1,
			source: style + ".tsx",
		}],
	}
	
}
for(let i = 0; i < 58; i++) {
	let raw_file_buf = fs.readFileSync('HEXZMAP/HEXZMAP.' + pad(i, 3));
	fs.writeFileSync('map' + pad(i, 3) + '.json', JSON.stringify(export2TileMap([...raw_file_buf])));
}
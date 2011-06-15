var winston = require('winston');

function leading_characters(_number, size, _character) {
    var character = _character.toString() || '0',
        number = _number.toString(),
        delta_size, i;

    if (number.length < size)
    {
        delta_size = size - number.length;

        for (i = 0; i < delta_size; ++i)
        {
            number = character + number;
        }
    }

    return number;
}

function Track(name, number, location, album)
{
    this.name = name;
    this.number = number;
    this.location = location;
    this.album = album;
}

Track.prototype = {};

Track.prototype.get_location = (function track_get_location (_format) {
    if (!this.album || !this.album.location)
        throw 'No album, or not location set for album: ' + this.album;

    // TODO: Find the best-choice format for the specific format
    if (this.album.formats && this.album.formats.indexOf(_format) == -1)
    {
        winston.warn('The specified format did not exist:' + _format);
    }

    var format_separator = _format.indexOf('/'),
        format_dir = _format,
        format;

    if (format_separator == -1)
        format = _format;
    else
        format = _format.slice(0, format_separator);

    return this.album.location + '/' + format_dir + '/'
                         + leading_characters(this.number, 2, '0') + ' '
                         + this.name + '.' + format;
});

module.exports = Track;

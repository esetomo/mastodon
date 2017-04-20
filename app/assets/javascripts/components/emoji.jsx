import emojione from 'emojione';

const toImage = str => iineToImage(shortnameToImage(unicodeToImage(str)));

const unicodeToImage = str => {
  const mappedUnicode = emojione.mapUnicodeToShort();

  return str.replace(emojione.regUnicode, unicodeChar => {
    if (typeof unicodeChar === 'undefined' || unicodeChar === '' || !(unicodeChar in emojione.jsEscapeMap)) {
      return unicodeChar;
    }

    const unicode  = emojione.jsEscapeMap[unicodeChar];
    const short    = mappedUnicode[unicode];
    const filename = emojione.emojioneList[short].fname;
    const alt      = emojione.convert(unicode.toUpperCase());

    return `<img draggable="false" class="emojione" alt="${alt}" src="/emoji/${filename}.svg" />`;
  });
};

const shortnameToImage = str => str.replace(emojione.regShortNames, shortname => {
  if (typeof shortname === 'undefined' || shortname === '' || !(shortname in emojione.emojioneList)) {
    return shortname;
  }

  const unicode = emojione.emojioneList[shortname].unicode[emojione.emojioneList[shortname].unicode.length - 1];
  const alt     = emojione.convert(unicode.toUpperCase());

  return `<img draggable="false" class="emojione" alt="${alt}" src="/emoji/${unicode}.svg" />`;
});

const iineToImage = str => str.replace(/:(iine|irane)(\d*):/g, (match, iine, deg) => {
  deg = deg ? deg : 0;
  status = iine == 'iine' ? 'active' : 'inactive';
  return `<i class="fa-iine ${status}" style="transform:rotate(${deg}deg);"></i>`;
});

export default function emojify(text) {
  return toImage(text);
};

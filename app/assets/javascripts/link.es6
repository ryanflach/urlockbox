$(document).ready(() => {
  handleReadStatusUpdate();
  searchBar();
  filterByReadStatus();
});

const handleReadStatusUpdate = () => {
  $('#links .status').on('click', (e) => {
    e.preventDefault();
    const id = $(e.target).closest('tr')[0].id;
    $.ajax({
      url: '/links/' + id,
      method: 'put',
      data: { id: id }
    }).then(createLinkHTML)
    .then(reRenderLink)
    .fail(handleError);
  });
};

const createLinkHTML = (linkData) => {
  return({
    id: linkData.id,
    html: "<tr id='" + linkData.id + "' class='link' data-all='" + linkData.title + " " + linkData.url +"'>" +
    "<td class='read-" + linkData.read + "'>" + linkData.title + "</td>" +
    "<td class='read-" + linkData.read + "'><a href='" + linkData.url + "'>" + linkData.url + "</a></td>" +
    "<td class='status'><a href='#'>" + newReadStatusText(linkData.read) + "</a></td>" +
    "<td><a href='/links/" + linkData.id + "/edit' class='btn btn-xs btn-default'> Edit </a></td>"
  });
};

const reRenderLink = (link) => {
  $('#' + link.id).replaceWith(link.html);
  handleReadStatusUpdate();
  searchBar();
  filterByReadStatus();
};

const newReadStatusText = (current) => {
  if (current === 'true') {
    return 'Mark as Unread';
  } else {
    return 'Mark as Read';
  }
};

const handleError = (error) => {
  console.log(error);
};

const searchBar = () => {
  const $links = $('.link');

  $('#search-box').on('keyup', (e) => {
    const currentEntry = e.target.value;

    $links.each((index, link) => {
      let $link = $(link);
      if ($link.data('all').toLowerCase().indexOf(currentEntry.toLowerCase()) !== -1){
        $link.show();
      } else {
        $link.hide();
      }
    });
  });
};

const filterByReadStatus = () => {
  const $links = $('.link');

  $('.filter').on('click', (e) => {
    const $button = $(e.target);

    $links.each((index, link) => {
      let $link = $(link);
      let linkStatus = $link.find('td').attr('class');
      if (
        ($button.text() === 'Filter Read' && linkStatus === 'read-false') ||
        ($button.text() === 'Filter Unread' && linkStatus === 'read-true')
      ) {
        $link.hide();
      } else {
        $link.show();
      }
    });
  });
};

const showAllLinks = () => {
  $.ajax({
    url: '/links.json'
  }).then(collectLinks)
  .then(renderLinks)
  .fail(handleError);
};

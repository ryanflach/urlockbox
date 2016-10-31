$(document).ready(() => {
  handleReadStatusUpdate();
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
    html: "<tr id='" + linkData.id + "'>" +
    "<td class='read-" + linkData.read + "'>" + linkData.title + "</td>" +
    "<td class='read-" + linkData.read + "'><a href='" + linkData.url + "'>" + linkData.url + "</a></td>" +
    "<td class='status'><a href='#'>" + newReadStatusText(linkData.read) + "</a></td>" +
    "<td><a href='/links/" + linkData.id + "/edit' class='btn btn-xs btn-default'> Edit </a></td>"
  });
};

const reRenderLink = (link) => {
  $('#' + link.id).replaceWith(link.html);
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

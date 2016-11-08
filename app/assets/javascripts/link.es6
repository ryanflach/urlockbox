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
      url: `api/v1/links/${id}`,
      method: 'put',
      data: { id: id }
    }).then(reRenderLink)
    .fail(handleError);
  });
};

// const createLinkHTML = (linkData) => {
//   return({
//     id: linkData.id,
//     html:
//       `<tr id='${linkData.id}' class='link' data-all='${linkData.title} ${linkData.url} ${linkData.tag_names}'>
//         <td class='read-${linkData.read}'>${linkData.title}</td>
//         <td class='read-${linkData.read}'><a href='${linkData.url}'>${linkData.url}</a></td>
//         <td class='tags'>${linkTagButtons(linkData.tags)}</td>
//         <td class='status'><a href='#'>${newReadStatusText(linkData.read)}</a></td>
//         <td><a href='/links/${linkData.id}/edit' class='btn btn-xs btn-default'>Edit</a></td>
//       </tr>`
//   });
// };

const reRenderLink = (link) => {
  console.log(`Link #${link.id} read status updated to ${link.read}`)
  $(`#${link.id} .status`).html(
    `<a href='#'>${newReadStatusText(link.read)}</a>`
  );
  $(`#${link.id} .affected-by-read`).toggleClass(`read-${link.read}`);
  // handleReadStatusUpdate();
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
    const buttonText = $(e.target).text();

    $links.each((index, link) => {
      let $link = $(link);
      let linkStatus = $link.find('td').attr('class');
      if (
        (buttonText === 'Filter Read' && linkStatus === 'read-false') ||
        (buttonText === 'Filter Unread' && linkStatus === 'read-true')
      ) {
        $link.hide();
      } else {
        $link.show();
      }
    });

    if (buttonText === 'Sort All A-Z') { sortAlphabetically($links); }
  });
};

const sortAlphabetically = (links) => {
  const sorted = links.sort((a, b) => {
    let titleA = $(a).children().first().text().toUpperCase();
    let titleB = $(b).children().first().text().toUpperCase();

    if (titleA < titleB) {
      return -1;
    } else if (titleA > titleB) {
      return 1;
    } else {
      return 0;
    }
  });

  $('.link-table-body').html(sorted);
  handleReadStatusUpdate();
};

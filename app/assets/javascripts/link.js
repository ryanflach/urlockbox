$(document).ready(() => {
  handleReadStatusUpdate();
});

const handleReadStatusUpdate = () => {
  $('#links .status').on('click', (e) => {
    e.preventDefault();
    const id = $(e.target).closest('tr')[0].id
    const
    console.log(id);
    $.ajax({
      url: '/links/' + id,
      method: 'put',
      data: { id: id }
    }).then(updateLink)
    .fail(handleError);
  });
};

const updateLink = (linkData) => {
  let counter = 0;
  $('#' + linkData.id)[0].children.forEach((child) => {
    if (counter === 0) { child.toggleClass('.read-true') }
    counter++;
  })
};

const handleError = (error) => {
  console.log(error)
};

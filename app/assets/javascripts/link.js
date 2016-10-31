$(document).ready(() => {
  listenForEdits();
});

const listenForStatusUpdate = () => {
  $('#links a').on('click', (e) => {
    e.preventDefault();
    $.ajax({
      url: '/ideas/' + 
    });
    $(e.target).toggleClass('read-true')
    console.log(e.target, "Clicked");
  });
};

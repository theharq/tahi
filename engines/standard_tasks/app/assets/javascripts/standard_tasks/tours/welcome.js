var cardTutorial = {
  id: "card-tutorial",
  steps: [
    {
      title: "All about the cards!",
      content: "Tahi is composed of many cards that look like this one. The card you are looking at is part of this paper.",
      target: "h2.overlay-header-title",
      placement: "bottom",
      zindex: 33000
    },
    {
      title: "Get to work!",
      content: "Every card will some work that you will need to perform.  It will be found in this area.",
      target: ".card-tutorial-content",
      placement: "top",
      xOffset: 300,
      zindex: 33000
    },
    {
      title: "Completion!",
      content: "Once your work is complete, simply mark it completed using this checkbox.  Once it is marked complete, you will not be able to make further changes.",
      target: "task_completed",
      placement: "left",
      yOffset: -20,
      zindex: 33000
    },
    {
      title: "Onward!",
      content: "Simply click the close button to go back to find more to do.  Easy, peasy.",
      target: "footer .overlay-close-button",
      placement: "top",
      zindex: 33000,
      multipage: true,
      onNext: function() {
        ETahi.Router.router.transitionTo('index')
        hopscotch.startTour(cardTutorial, 4)
      }
    },
    {
      title: "Here's your dashboard!",
      content: "This is your dashboard which shows all your papers",
      target: "h2.overlay-header-title",
      placement: "bottom",
      zindex: 33000
    },
  ]
};

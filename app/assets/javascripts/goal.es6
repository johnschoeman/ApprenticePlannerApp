document.addEventListener("DOMContentLoaded", () => {
  const goal_list = document.getElementById("goal-list");
  goal_list.addEventListener("click", (event) => {
    let goalId = event.target.dataset.goalId;
    if (goalId) {
      let url = Routes.api_goal_url(goalId);
      // let csrf = document.querySelector('meta[name=csrf-token')
      // let csrfToken = csrf.content
      let csrfToken = $('meta[name=csrf-token]').attr('content')

      fetch(url, {
        method: 'PUT',
        headers: new Headers({
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': csrfToken
        }),
        credentials: 'same-origin'
      })
    }
  }, false);
})

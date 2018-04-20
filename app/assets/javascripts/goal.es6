document.addEventListener("DOMContentLoaded", () => {
  const goal_list = document.querySelector("ul.goal-list");
  goal_list.addEventListener("click", (event) => {
    let goalId = event.target.dataset.goalId;
    if (goalId) {
      let url = Routes.api_goal_url(goalId);
      let csrfToken = document.querySelector('meta[name=csrf-token]').content;
      fetch(url, {
        method: 'PUT',
        headers: new Headers({
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': csrfToken
        }),
        credentials: 'same-origin'
      }).then(res => handleResult(res))
        .catch(err => handleErrors(err));
    }
  }, false);
})

const handleResult = (result) => {
  if (!result.ok) {
    resetGoal(); // TODO: reset the goal in the UI since the request failed.
    throw Error(result.statusText);
  }
};

const handleErrors = (errors) => {
  const alertMessage = `Error saving goal:  ${errors}`;
  alert(alertMessage);
};

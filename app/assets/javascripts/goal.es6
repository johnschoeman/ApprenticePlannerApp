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
      }).then(res => handleErrors(res))
        .catch(err => console.log(err));

    }
  }, false);
})

const handleErrors = (res) => {
  if (!res.ok) {
    const alertMessage = `Error saveing goal: status: ${res.status} ${res.statusText}`;
    alert(alertMessage);
  }
};

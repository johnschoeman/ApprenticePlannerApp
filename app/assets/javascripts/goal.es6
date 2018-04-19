// Routes.configure({
//     url_links: true
// });
// Routes.config();

 document.addEventListener("DOMContentLoaded", () => {

   console.log("Routes: ", Routes);
   console.log(Routes.api_goal_url(1));

    const goal_list = document.getElementById("goal-list");
    goal_list.addEventListener("click", (event) => {
      let goalId = event.target.dataset.goalId;
      if (goalId) {
        let url = Routes.api_goal_url(goalId);
        console.log("url: ", url);
        let csrfToken = document.getElementsByName("csrf-token")[0].content;

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

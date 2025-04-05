window.addEventListener("message", function (event) {
  let data = event.data;

  switch (data.action) {
    case "openUI":
      document.querySelector(".car-statistics").style.display = "flex";
      document.getElementById("speed").textContent = data.speed;
      document.getElementById("progress-fill").style.width =
        `${data.speed / 2.15}%`;
      document.getElementById("runs").textContent = data.gear;
      document.getElementById("fuel-border").style.height = data.fuel
        ? `${data.fuel}%`
        : "0%";
      document.getElementById("repair-border").style.height =
        data.getStateVehicle ? `${data.getStateVehicle}%` : "0%";
      document.getElementById("fuel").style.color =
        data.fuel < 0 ? "#f54242" : "#ffffff";
      document.getElementById("light").style.color = data.light
        ? "#00fbff"
        : "#f54242";
      break;

    case "closeUI":
      document.querySelector(".car-statistics").classList.add("close");
      setTimeout(() => {
        document.querySelector(".car-statistics").style.display = "none";
        document.querySelector(".car-statistics").classList.remove("close");
      }, 550);
      break;

    case "openStats":
      document.querySelector(".hud-statistics").style.display = "flex";
      break;

    case "updateStatus":
      document.getElementById("health-border").style.height = `${data.health}%`;
      document.getElementById("food-border").style.height = `${data.hunger}%`;
      document.getElementById("drink-border").style.height = `${data.hunger}%`;

      if (data.armor > 0) {
        document.querySelector(".box-armor").style.display = "flex";
        document.getElementById("armor-border").style.height = `${data.armor}%`;
      } else {
        document.querySelector(".box-armor").classList.add("close");
        setTimeout(() => {
          document.querySelector(".box-armor").style.display = "none";
          document.querySelector(".box-armor").classList.remove("close");
        }, 550);
      }

      document.querySelector(".box-mic").style.opacity = data.talking
        ? "0.5"
        : "1";
      break;
  }
});

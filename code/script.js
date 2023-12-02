// Create a "close" button and append it to each list item
var myNodelist = document.getElementsByTagName("LI");
var i;
for (i = 0; i < myNodelist.length; i++) {
  // gumb za odstranitev opravila
  var span = document.createElement("SPAN");
  var txt = document.createTextNode("\u00D7");
  span.className = "close";
  span.appendChild(txt);
  myNodelist[i].appendChild(span);

  // shopping list
  var shoppingBtn = document.createElement("SPAN");
  shoppingBtn.className = "shoppingBtn";
  var txt2 = document.createTextNode("SHOPPING");
  shoppingBtn.appendChild(txt2);
  myNodelist[i].appendChild(shoppingBtn);

  // drink list
  var drinkBtn = document.createElement("SPAN");
  drinkBtn.className = "drinkBtn";
  var txt3 = document.createTextNode("DRINK");
  drinkBtn.appendChild(txt3);
  myNodelist[i].appendChild(drinkBtn);
}

// Click on a close button to hide the current list item
var close = document.getElementsByClassName("close");
var i;
for (i = 0; i < close.length; i++) {
  close[i].onclick = function() {
    var div = this.parentElement;
    if(document.getElementsByName("guest").length > 0){
      alert("Nimaš pravic za izbris vnosa!");
      exit;
    }
    if(confirm("Ali ste prepričani, da želite izbrisati izbran vnos?")){
      let data = {
        id: div.getAttribute("id")
      };
      let xhr = new XMLHttpRequest();

      // Set the request URL and method
      xhr.open("POST", "deleteEntry.php");

      // Set the request header to indicate the data type
      xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

      // Define a callback function to handle the server's response
      xhr.onload = function() {
          if (xhr.status === 200) {
              location.reload();
          }
      };

      // Convert the data to a JSON string and send it to the server
      xhr.send(JSON.stringify(data));
    }
    //div.style.display = "none";
  }
}

// Add a "checked" symbol when clicking on a list item
var list = document.querySelector('ul');
list.addEventListener('click', function(ev) {
  if (ev.target.tagName === 'LI') {
    //ev.target.classList.toggle('checked');
    //console.log(ev.target.getAttribute("id"));
    if(document.getElementsByName("guest").length > 0){
      alert("Nimaš pravic za spreminjanje stanja!");
      exit;
    }
    if(ev.target.classList.contains("checked")){
      let data = {
        finished: 0,
        id: ev.target.getAttribute("id")
      }
      //console.log(ev.target.getAttribute("id"));
      // Create a new XMLHttpRequest object
      let xhr = new XMLHttpRequest();

      // Set the request URL and method
      xhr.open("POST", "updateFinished.php");

      // Set the request header to indicate the data type
      xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

      // Define a callback function to handle the server's response
      xhr.onload = function() {
          if (xhr.status === 200) {
              location.reload();
          }
      };

      // Convert the data to a JSON string and send it to the server
      xhr.send(JSON.stringify(data));
    }
    else{
      let data = {
        finished: 1,
        id: ev.target.getAttribute("id")
      }
      // Create a new XMLHttpRequest object
      let xhr = new XMLHttpRequest();

      // Set the request URL and method
      xhr.open("POST", "updateFinished.php");

      // Set the request header to indicate the data type
      xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

      // Define a callback function to handle the server's response
      xhr.onload = function() {
          if (xhr.status === 200) {
              location.reload();
          }
      };

      // Convert the data to a JSON string and send it to the server
      xhr.send(JSON.stringify(data));
    }
  }
}, false);

// Create a new list item when clicking on the "Add" button
function newElement() {
  var li = document.createElement("li");
  var inputValue = document.getElementById("todo").value;
  var t = document.createTextNode(inputValue);
  var dropdown = document.getElementById("groups");
  var selectedGroup = dropdown.value;
  var dateInput = document.getElementById("date");
  var dateValue = dateInput.value;
  li.appendChild(t);
  if (inputValue === '' && dateInput === '') {
    alert("Izpolni vsa polja!");
  } else {
    //document.getElementById("myUL").appendChild(li);
    
    let data = {
      toDo: inputValue,
      groupId: selectedGroup,
      deadline: dateValue
    }
    
    // Create a new XMLHttpRequest object
    let xhr = new XMLHttpRequest();

    // Set the request URL and method
    xhr.open("POST", "add.php");

    // Set the request header to indicate the data type
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

    // Define a callback function to handle the server's response
    xhr.onload = function() {
        if (xhr.status === 200) {
            location.reload();
        }
    };

    // Convert the data to a JSON string and send it to the server
    xhr.send(JSON.stringify(data));
  }
  document.getElementById("todo").value = "";

  var span = document.createElement("SPAN");
  var txt = document.createTextNode("\u00D7");
  span.className = "close";
  span.appendChild(txt);
  li.appendChild(span);

  for (i = 0; i < close.length; i++) {
    close[i].onclick = function() {
      var div = this.parentElement;
      div.style.display = "none";
    }
  }
}

// za nastavitve
var optionsButton = document.getElementById('options-button');
var optionsWindow = document.getElementById('options-window');
var createGroup = document.getElementById('skupina');
var addToGroup = document.getElementById('dodajskupina');
var changePassword = document.getElementById('spremenigeslo');

optionsButton.addEventListener('click', function() {
  optionsWindow.classList.toggle('show');
});

window.addEventListener("click", (event) => {
  if (event.target !== optionsButton && event.target !== optionsWindow && event.target !== createGroup && event.target !== addToGroup && event.target !== changePassword) {
    if(optionsWindow.classList.contains("show")){
      optionsWindow.classList.toggle('show');
    }
  }
});

// za shopping in drink seznam
//shopping
var shoppingWindow = document.getElementById("shopping-window");

const shoppingButtons = Array.from(document.getElementsByClassName('shoppingBtn'));

shoppingButtons.forEach(btn => {
  btn.addEventListener('click', function handleClick(event) {
    shoppingWindow.classList.toggle('show');
  });
});

window.addEventListener("click", (event) => {
  if (event.target !== shoppingWindow &&!shoppingButtons.some(button => event.target === button) && shoppingWindow.classList.contains("show")) {
    shoppingWindow.classList.toggle('show');
  }
});

//drink
var drinkWindow = document.getElementById("drink-window");

const drinkButtons = Array.from(document.getElementsByClassName('drinkBtn'));

drinkButtons.forEach(btn => {
  btn.addEventListener('click', function handleClick(event) {
    drinkWindow.classList.toggle('show');
  });
});

window.addEventListener("click", (event) => {
  if (event.target !== drinkWindow &&!drinkButtons.some(button => event.target === button) && drinkWindow.classList.contains("show")) {
    drinkWindow.classList.toggle('show');
  }
});


// koda za koledar
// to doda koledar iz full calendar API-ja
document.addEventListener('DOMContentLoaded', function () {
  fetch('eventData.php')
    .then(response => response.json())
    .then(data => {
      var calendarEl = document.getElementById('calendar');
      const calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'timeGridWeek',
        events: data
      });
      calendar.render();
    })
    .catch(error => console.error('Error fetching data:', error));
});
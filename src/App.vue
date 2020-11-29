<template>
  <div id="app">
    <textarea id="notes" v-model="notesText" placeholder="Notes"></textarea>
    <div>
      <ul v-for="(t, idx) in timers" v-bind:key="makeKey(idx, t.timestamp)">
        <Timer
          :id="idx"
          :name="t.name"
          :timestamp="t.timestamp"
          :length="t.length"
          :updateFunction="updateTimer"
          :deleteFunction="deleteTimer"
        ></Timer>
      </ul>
    </div>
    <div>
      <button class="mainButton" v-on:click="addTimer">Add Timer</button>
    </div>
    <div>
      <button class="mainButton" v-on:click="resetTimers">Delete All</button>
    </div>
  </div>
</template>

<script>
import Vue from "vue";
import Timer from "./components/Timer.vue";

export default {
  name: "App",
  components: {
    Timer,
  },
  data: function () {
    return { timers: [], notesText: "" };
  },
  methods: {
    makeKey(index, timestamp) {
      return index + ":" + timestamp;
    },
    loadTimers() {
      if (localStorage.timers) {
        this.timers = JSON.parse(localStorage.timers);
      }
    },
    loadNotes() {
      if (localStorage.notes) {
        let textarea = document.querySelector("#notes");
        textarea.value = localStorage.notes;
        textarea.dispatchEvent(new Event("input"));
      }
    },
    saveTimers() {
      localStorage.setItem("timers", JSON.stringify(this.timers));
    },
    saveNotes() {
      localStorage.setItem("notes", this.notesText);
    },
    deleteTimer(idx) {
      this.timers.splice(idx, 1);
      this.saveTimers();
    },
    updateTimer(timer) {
      let idx = timer.id;
      Vue.delete(timer, "id");
      this.timers.splice(idx, 1, timer);
      this.saveTimers();
    },
    makeTimer(name, timestamp, length) {
      return {
        name: name,
        timestamp: timestamp,
        length: length,
      };
    },
    makeDefaultTimer() {
      return this.makeTimer("Timer Name", -1, 24);
    },
    addTimer() {
      this.timers.push(this.makeDefaultTimer());
      this.saveTimers();
    },
    resetTimers() {
      this.timers = [];
      this.saveTimers();
    },
  },
  mounted: function () {
    this.loadTimers();
    let textarea = document.querySelector("#notes");
    textarea.addEventListener("input", autoResize, false);
    let saveNotes = this.saveNotes;
    function autoResize() {
      this.style.height = "auto";
      this.style.height = this.scrollHeight + "px";
      saveNotes();
    }
    this.loadNotes();
  },
};
</script>

<style>
html {
  background: rgb(80, 80, 80);
  min-width: 600px;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;

  text-align: center;
  margin-top: var(--top-margin);
  color: var(--text-color);

  --top-margin: 1em;
  --corners: 25px;
  --content-width: 40%;
  --main-button-height: 1.5em;
  --main-button-font-size: 2em;
  --bg-color: rgb(60, 60, 60);
  --text-color: white;
}
#notes {
  display: flex;
  position: absolute;
  width: 25%;
  min-width: 150px;
  resize: none;
  margin-top: var(--top-margin);
  margin-left: 0;
  outline: none;
  background: var(--bg-color);
  color: var(--text-color);
  font-size: 1em;
}
ul {
  display: inline;
  justify-content: center;
}
.timer {
  width: var(--content-width);
}
input {
  color: var(--text-color);
  background: var(--bg-color);
}
button {
  color: var(--text-color);
  background: var(--bg-color);
  outline: none;
}
.mainButton {
  margin-top: var(--top-margin);
  height: var(--main-button-height);
  font-size: var(--main-button-font-size);
  width: var(--content-width);
  border-radius: var(--corners);
}
</style>

<template>
  <div class="timer">
    <input class="text" v-model="fieldName" />
    <h1 v-bind:style="timeStyle">{{ remainingTimeToString(remainingTime) }}</h1>
    <div class="radio-group" v-for="o in options" v-bind:key="o">
      <div class="radio-option">
        <label :for="o">{{ o + "H" }}</label>
        <input class="radio" type="radio" :value="o" v-model="picked" />
      </div>
    </div>
    <button class="setButton" v-on:click="this.updateTimestamp">
      Set Timer
    </button>
    <div class="smallButtons">
      <button class="stopButton" v-on:click="stopTimer">Stop</button>
      <button class="deleteButton" v-on:click="deleteFunction(id)">
        Delete
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: "Timer",
  props: {
    id: Number,
    name: String,
    timestamp: Number,
    length: Number,
    updateFunction: Function,
    deleteFunction: Function,
  },
  data: function () {
    return {
      picked: this.length,
      options: [12, 24, 48, 72],
      remainingTime: Math.max(0, this.endTime() - Date.now()),
    };
  },
  methods: {
    update(id, name, timestamp, length) {
      this.updateFunction({
        id: id,
        name: name,
        timestamp: timestamp,
        length: length,
      });
    },
    updateLength() {
      this.update(this.id, this.name, this.timestamp, this.picked);
    },
    updateTimestamp() {
      this.update(this.id, this.name, Date.now(), this.picked);
    },
    endTime() {
      return this.timestamp + this.length * 60 * 60 * 1000;
    },
    stopTimer() {
      this.update(this.id, this.name, -1, this.picked);
    },
    remainingTimeToString(milliseconds) {
      // https://stackoverflow.com/questions/19700283/how-to-convert-time-milliseconds-to-hours-min-sec-format-in-javascript
      // Get hours from milliseconds
      var hours = milliseconds / (1000 * 60 * 60);
      var absoluteHours = Math.floor(hours);
      var h = absoluteHours > 9 ? absoluteHours : "0" + absoluteHours;

      // Get remainder from hours and convert to minutes
      var minutes = (hours - absoluteHours) * 60;
      var absoluteMinutes = Math.floor(minutes);
      var m = absoluteMinutes > 9 ? absoluteMinutes : "0" + absoluteMinutes;

      // Get remainder from minutes and convert to seconds
      var seconds = (minutes - absoluteMinutes) * 60;
      var absoluteSeconds = Math.floor(seconds);
      var s = absoluteSeconds > 9 ? absoluteSeconds : "0" + absoluteSeconds;

      return h + ":" + m + ":" + s;
    },
  },
  computed: {
    fieldName: {
      get() {
        return this.name;
      },
      set(newValue) {
        this.update(this.id, newValue, this.timestamp, this.length);
      },
    },
    timeStyle() {
      if (this.remainingTime > 0) {
        return { color: "red" };
      }
      return { color: "green" };
    },
  },
  watch: {
    remainingTime: {
      handler(value) {
        if (value > 0) {
          setTimeout(() => {
            this.remainingTime = Math.max(0, this.endTime() - Date.now());
          }, 1000);
        }
      },
      immediate: true,
    },
  },
};
</script>

<style scoped>
.timer {
  margin: 0 auto;
  border: 2px solid black;
  border-radius: var(--corners);

  --corners: 25px;
}
input.text {
  width: 100%;
  height: 1.5em;
  font-size: 2em;
  outline: none;
  box-sizing: border-box;
  text-align: center;
  border-top-left-radius: var(--corners);
  border-top-right-radius: var(--corners);
  box-sizing: border-box;
}
h1 {
  text-align: center;
  font-size: 3em;
  margin: 0;
}
.smallButtons {
  text-align: right;
}
.stopButton,
.deleteButton {
  outline: none;
  width: 25%;
}
.deleteButton {
  border-bottom-right-radius: var(--corners);
}
.setButton {
  width: 100%;
  height: 1.5em;
  font-size: 2.5em;
  outline: none;
}
.radio-group {
  display: inline-block;
  margin-left: 3px;
  margin-right: 3px;
}
.radio {
  display: block;
  width: 2em;
  height: 2em;
  margin-bottom: 5px;
}
</style>
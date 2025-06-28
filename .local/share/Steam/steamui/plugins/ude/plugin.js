// UDE Steam Deck UI Plugin
const { TdpSlider, GameProfiles } = window.SteamClient;

export default class UDEPlugin {
  static styles = `
    .ude-container {
      padding: 15px;
      background: rgba(28, 28, 28, 0.95);
      border-radius: 10px;
    }
    .ude-slider {
      width: 100%;
      margin: 10px 0;
    }
  `;

  render() {
    return `
      <div class="ude-container">
        <h3>Ultimate Deck Experience</h3>
        <div class="ude-slider">
          <label>TDP Control: <span id="ude-tdp-value">10W</span></label>
          <input type="range" min="3" max="15" value="10" 
                 oninput="document.getElementById('ude-tdp-value').textContent=this.value+'W'">
        </div>
        <button onclick="GameProfiles.apply('battery')">Battery Saver</button>
      </div>
    `;
  }
}

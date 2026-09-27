<style>
	@media screen and (min-width: 601px) {
  .labelFonts {
    font-size: 20px;
    font-style: italic;color: darkblue;font-weight: 800;
  }
}

@media screen and (max-width: 600px) {
  .labelFonts {
    font-size: 15px;
    font-style: italic;color: darkblue;font-weight: 800;
  }
}

/* --- algo dashboard helpers (dummy-data build) --- */
.gain { color:#28a745; font-weight:600; }
.loss { color:#dc3545; font-weight:600; }
.mono { font-family: 'Courier New', monospace; }
.badge-strategy { background:#17a2b8; color:#fff; padding:2px 8px; border-radius:4px; font-size:11px; }
.badge-paper { background:#6c757d; color:#fff; padding:2px 8px; border-radius:4px; font-size:11px; }
</style>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ==========================================================
     NOTE: This page uses static/dummy values as requested.
     Replace the hard-coded numbers below with EL expressions
     bound to request-scope attributes (the same pattern as
     ${HomePageContent.get('...')} in the original dashboard)
     once real broker / strategy-engine data is wired in.
     ========================================================== --%>

<c:set var="HomePageContent" value='${requestScope["outputObject"]}' />

<br>

<!-- ===================== QUICK ACTIONS ===================== -->
<div class="row">
  <div class="col-12 col-sm-6 col-md-3" onclick="window.location='?a=showPlaceOrder'">
    <div class="info-box">
      <span class="info-box-icon bg-info elevation-1"><i class="fas fa-pencil-square-o"></i></span>
      <div class="info-box-content">
        <span class="info-box-text">Place Order</span>
      </div>
    </div>
  </div>

  <div class="col-12 col-sm-6 col-md-3" onclick="window.location='?a=showStrategyMaster'">
    <div class="info-box">
      <span class="info-box-icon bg-secondary elevation-1"><i class="fas fa-cogs"></i></span>
      <div class="info-box-content">
        <span class="info-box-text">Manage Strategies</span>
      </div>
    </div>
  </div>

  <div class="clearfix hidden-md-up"></div>

  <div class="col-12 col-sm-6 col-md-3" onclick="window.location='?a=showPositions'">
    <div class="info-box mb-3">
      <span class="info-box-icon bg-success elevation-1"><i class="fas fa-list-alt"></i></span>
      <div class="info-box-content">
        <span class="info-box-text">View Positions</span>
      </div>
    </div>
  </div>

  <div class="col-12 col-sm-6 col-md-3" onclick="window.location='?a=confirmSquareOffAll'">
    <div class="info-box mb-3">
      <span class="info-box-icon bg-warning elevation-1"><i class="fas fa-power-off"></i></span>
      <div class="info-box-content">
        <span class="info-box-text">Square Off All</span>
      </div>
    </div>
  </div>
</div>

<!-- ===================== INDEX TICKERS ===================== -->
<div class="row">
  <div class="col-lg-6 col-12">
    <div class="small-box bg-success">
      <div class="inner">
        <h3 class="mono">81,624.30</h3>
        <p>BSE SENSEX &nbsp; <span class="mono">&#9650; 312.45 (0.38%)</span></p>
      </div>
      <div class="icon"><i class="ion ion-stats-bars"></i></div>
      <a href="?a=showIndexChart&index=SENSEX" class="small-box-footer">Chart <i class="fas fa-arrow-circle-right"></i></a>
    </div>
  </div>

  <div class="col-lg-6 col-12">
    <div class="small-box bg-success">
      <div class="inner">
        <h3 class="mono">24,981.15</h3>
        <p>NIFTY 50 &nbsp; <span class="mono">&#9650; 88.20 (0.35%)</span></p>
      </div>
      <div class="icon"><i class="ion ion-stats-bars"></i></div>
      <a href="?a=showIndexChart&index=NIFTY" class="small-box-footer">Chart <i class="fas fa-arrow-circle-right"></i></a>
    </div>
  </div>
</div>

<!-- ===================== ACCOUNT KPIs ===================== -->
<div class="row">
  <div class="col-lg-3 col-6" onclick="window.location='?a=showPnlReport'">
    <div class="small-box bg-success">
      <div class="inner">
        <h3 class="mono">+&#8377;23,985</h3>
        <p>Today's P&amp;L</p>
      </div>
      <div class="icon"><i class="ion ion-cash"></i></div>
      <a href="#" onclick="window.location='?a=showPnlReport'" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
    </div>
  </div>

  <div class="col-lg-3 col-6" onclick="window.location='?a=showPnlReport&range=MTD'">
    <div class="small-box bg-info">
      <div class="inner">
        <h3 class="mono">+&#8377;1,84,260</h3>
        <p>MTD P&amp;L</p>
      </div>
      <div class="icon"><i class="ion ion-stats-bars"></i></div>
      <a href="#" onclick="window.location='?a=showPnlReport&range=MTD'" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
    </div>
  </div>

  <div class="col-lg-3 col-6" onclick="window.location='?a=showPositions'">
    <div class="small-box bg-warning">
      <div class="inner">
        <h3>7</h3>
        <p>Open Positions</p>
      </div>
      <div class="icon"><i class="ion ion-briefcase"></i></div>
      <a href="#" onclick="window.location='?a=showPositions'" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
    </div>
  </div>

  <div class="col-lg-3 col-6" onclick="window.location='?a=showStrategyMaster'">
    <div class="small-box bg-danger">
      <div class="inner">
        <h3>3 / 5</h3>
        <p>Algos Running</p>
      </div>
      <div class="icon"><i class="ion ion-flash"></i></div>
      <a href="#" onclick="window.location='?a=showStrategyMaster'" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
    </div>
  </div>
</div>

<!-- ===================== OPEN POSITIONS ===================== -->
<div class="col-sm-12">
  <div class="card card-primary">
    <div class="card-header">
      <h3 class="card-title">Open Positions</h3>
      <div class="card-tools">
        <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
        <button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-times"></i></button>
      </div>
    </div>
    <div class="card-body table-responsive p-0">
      <table class="table table-striped table-valign-middle mono">
        <thead>
        <tr>
          <th>Symbol</th>
          <th>Segment</th>
          <th>Qty</th>
          <th>Avg</th>
          <th>LTP</th>
          <th>P&amp;L</th>
          <th>P&amp;L %</th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td><a href="?a=showPositionDetail&symbol=RELIANCE">RELIANCE</a></td>
          <td>NIFTY50</td><td>150</td><td>2,843.10</td><td>2,871.55</td>
          <td class="gain">+&#8377;4,268</td><td class="gain">+1.00%</td>
        </tr>
        <tr>
          <td><a href="?a=showPositionDetail&symbol=HDFCBANK">HDFCBANK</a></td>
          <td>NIFTY50</td><td>200</td><td>1,652.40</td><td>1,639.80</td>
          <td class="loss">&#8722;&#8377;2,520</td><td class="loss">&#8722;0.76%</td>
        </tr>
        <tr>
          <td><a href="?a=showPositionDetail&symbol=ICICIBANK">ICICIBANK</a></td>
          <td>NIFTY50</td><td>180</td><td>1,198.75</td><td>1,214.90</td>
          <td class="gain">+&#8377;2,907</td><td class="gain">+1.35%</td>
        </tr>
        <tr>
          <td><a href="?a=showPositionDetail&symbol=TCS">TCS</a></td>
          <td>SENSEX</td><td>60</td><td>4,102.00</td><td>4,088.25</td>
          <td class="loss">&#8722;&#8377;825</td><td class="loss">&#8722;0.34%</td>
        </tr>
        <tr>
          <td><a href="?a=showPositionDetail&symbol=BAJFINANCE">BAJFINANCE</a></td>
          <td>SENSEX</td><td>40</td><td>7,210.50</td><td>7,305.10</td>
          <td class="gain">+&#8377;3,784</td><td class="gain">+1.31%</td>
        </tr>
        <tr>
          <td><a href="?a=showPositionDetail&symbol=NIFTY25000CE">NIFTY 25000 CE</a></td>
          <td>OPTIONS</td><td>75</td><td>142.30</td><td>168.75</td>
          <td class="gain">+&#8377;1,984</td><td class="gain">+18.59%</td>
        </tr>
        <tr>
          <td><a href="?a=showPositionDetail&symbol=NIFTY24800PE">NIFTY 24800 PE</a></td>
          <td>OPTIONS</td><td>75</td><td>98.60</td><td>81.20</td>
          <td class="loss">&#8722;&#8377;1,305</td><td class="loss">&#8722;17.65%</td>
        </tr>
        <tr>
          <td>Total</td><td></td><td></td><td></td><td></td>
          <td class="gain">+&#8377;8,293</td><td></td>
        </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- ===================== STRATEGY PERFORMANCE ===================== -->
<div class="col-sm-12">
  <div class="card card-primary">
    <div class="card-header">
      <h3 class="card-title">Strategy Performance (Today)</h3>
      <div class="card-tools">
        <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
        <button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-times"></i></button>
      </div>
    </div>
    <div class="card-body table-responsive p-0">
      <table class="table table-striped table-valign-middle mono">
        <thead>
        <tr>
          <th>Strategy</th>
          <th>Instrument</th>
          <th>Status</th>
          <th>Trades</th>
          <th>Win Rate</th>
          <th>Sharpe</th>
          <th>P&amp;L</th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td><a href="?a=showStrategyDetail&name=MomentumBreakout">Momentum Breakout</a></td>
          <td>NIFTY Futures</td>
          <td><span class="badge-strategy">RUNNING</span></td>
          <td>22</td><td>64%</td><td>1.8</td>
          <td class="gain">+&#8377;18,420</td>
        </tr>
        <tr>
          <td><a href="?a=showStrategyDetail&name=MeanReversion">Mean Reversion</a></td>
          <td>Sensex Constituents</td>
          <td><span class="badge-strategy">RUNNING</span></td>
          <td>15</td><td>51%</td><td>0.6</td>
          <td class="loss">&#8722;&#8377;4,110</td>
        </tr>
        <tr>
          <td><a href="?a=showStrategyDetail&name=OptionsTheta">Options Theta</a></td>
          <td>NIFTY Weekly Options</td>
          <td><span class="badge-strategy">RUNNING</span></td>
          <td>9</td><td>78%</td><td>2.1</td>
          <td class="gain">+&#8377;9,675</td>
        </tr>
        <tr>
          <td><a href="?a=showStrategyDetail&name=PairsArb">Pairs Arb (BANKNIFTY)</a></td>
          <td>Bank Nifty Pairs</td>
          <td><span class="badge-paper">PAPER</span></td>
          <td>4</td><td>50%</td><td>0.3</td>
          <td class="gain">+&#8377;620</td>
        </tr>
        <tr>
          <td><a href="?a=showStrategyDetail&name=GapUpScalper">Gap-Up Scalper</a></td>
          <td>NIFTY Futures</td>
          <td><span class="badge-paper">PAUSED</span></td>
          <td>0</td><td>&#8212;</td><td>&#8212;</td>
          <td>&#8377;0</td>
        </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- ===================== ORDER LOG ===================== -->
<div class="col-sm-12">
  <div class="card card-primary">
    <div class="card-header">
      <h3 class="card-title">Recent Order Log</h3>
      <div class="card-tools">
        <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
        <button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-times"></i></button>
      </div>
    </div>
    <div class="card-body table-responsive p-0">
      <table class="table table-striped table-valign-middle mono">
        <thead>
        <tr>
          <th>Time</th>
          <th>Strategy</th>
          <th>Side</th>
          <th>Symbol</th>
          <th>Qty</th>
          <th>Price</th>
          <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <tr><td>10:41:52</td><td>Momentum Breakout</td><td class="gain">BUY</td><td>NIFTY FUT</td><td>50</td><td>24,978.00</td><td>FILLED</td></tr>
        <tr><td>10:40:11</td><td>Options Theta</td><td class="loss">SELL</td><td>NIFTY 24800 PE</td><td>75</td><td>81.20</td><td>FILLED</td></tr>
        <tr><td>10:38:47</td><td>Mean Reversion</td><td class="gain">BUY</td><td>ICICIBANK</td><td>60</td><td>1,214.10</td><td>FILLED</td></tr>
        <tr><td>10:36:05</td><td>Momentum Breakout</td><td class="loss">SELL</td><td>NIFTY FUT</td><td>50</td><td>24,955.50</td><td>FILLED</td></tr>
        <tr><td>10:33:22</td><td>Options Theta</td><td class="gain">BUY</td><td>NIFTY 25000 CE</td><td>75</td><td>168.75</td><td>FILLED</td></tr>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- ===================== RISK & MARGIN ===================== -->
<div class="row">
  <div class="col-sm-6">
    <div class="card card-primary">
      <div class="card-header"><h3 class="card-title">Margin</h3></div>
      <div class="card-body table-responsive p-0">
        <table class="table table-striped table-valign-middle mono">
          <tbody>
          <tr><td>Capital deployed</td><td>&#8377;12,40,000</td></tr>
          <tr><td>Margin used</td><td>&#8377;4,86,300 (39%)</td></tr>
          <tr><td>Available margin</td><td>&#8377;7,53,700</td></tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <div class="col-sm-6">
    <div class="card card-primary">
      <div class="card-header"><h3 class="card-title">Risk</h3></div>
      <div class="card-body table-responsive p-0">
        <table class="table table-striped table-valign-middle mono">
          <tbody>
          <tr><td>Max drawdown (30d)</td><td class="loss">&#8722;4.2%</td></tr>
          <tr><td>Value at Risk (1d, 95%)</td><td>&#8377;38,900</td></tr>
          <tr><td>Net exposure</td><td>1.32&#215;</td></tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
  document.getElementById("divTitle").innerHTML = "Algo Trading Dashboard";
</script>

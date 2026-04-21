# Project Proposal: 基於邊緣視覺運算與 Raspberry Pi 物聯網協同之智慧坐姿監修系統

## 1. Introduction (Abstract A. to F.)
*   **[A] Attention (Motivation):** 隨著數位化辦公與遠距學習的普及，現代人長時間面對螢幕，不良坐姿（如烏龜頸、駝背）導致的脊椎疲勞與視力退化已成為重大健康隱憂。建立具備即時性與無干擾性的健康監控系統，成為現代智慧空間環境研究的重要議題。
*   **[B] But (Challenge):** 然而，現有之坐姿矯正方案多存在顯著缺陷：穿戴式設備（如 IMU 感測器）會對使用者造成物理負擔與違和感，導致長期使用率低落；而純軟體層面的視覺檢測工具，則缺乏實體環境的反饋機制，無法有效打斷使用者的沉浸狀態並促使其改變姿勢。此外，多數系統缺乏長期數據追蹤與視覺化介面，使用者難以評估自身的改善狀況。
*   **[C] Cure (Solution):** We propose a distributed, vision-based ambient intelligence system combining Edge Computing, ESP32 microcontrollers, and a Web-based Dashboard。本專案提出一種分散式智慧環境系統，結合邊緣視覺運算、微控制器與數據視覺化網頁，達成「零穿戴負擔」、「多維度實體反饋」與「長期姿態評分追蹤」的坐姿監修架構。
*   **[D] Development (Design):** 我們的方法設計基於軟硬體解耦架構。前端視覺節點運行 MediaPipe 進行骨架特徵點擷取，計算頭頸角度與空間距離。當偵測到姿勢異常時，系統透過 MQTT 協定發送指令至 ESP32 驅動實體反饋（RGB 警示燈效、蜂鳴器）。同時，視覺節點會將姿態數據（包含即時推論指標與歷史 CSV 日誌）推播至網頁後端，並透過動態網頁介面呈現即時坐姿評分、健康趨勢圖表與網頁端警示通知。
*   **[E] Experiments (Evaluation):** To evaluate our proposed scheme, we conduct experiments on (1) 端到端通訊延遲、(2) 不同環境光源下骨架辨識之準確度 (Accuracy)、(3) 比較系統介入前後，受測者維持標準坐姿的時間佔比變化，(4) 透過網頁儀表板分析受測者單週內的坐姿健康評分 (Posture Score) 趨勢。
*   **[F] Findings (Results):** Results are expected to show that 本系統能在極低延遲下提供精準的坐姿警告，且相較於傳統穿戴式設備，具備跨設備整合優勢。搭配直觀的圖表化網頁反饋，能大幅提升使用者自我修正的動機與接受度，證明其在智慧辦公空間中的實用價值。

## 2. Related Work / NotebookLM
透過文獻探討與 NotebookLM 輔助歸納，當前坐姿檢測領域主要分為兩大技術流派，本系統截長補短並提出改良：
*   **基於微機電感測器 (MEMS-based Wearables):**
    *   **現有技術：** 依賴 MPU6050 (慣性測量單元) 貼附於頸部或背部，計算傾斜角。
    *   **侷限性：** 存在物理摩擦感，且需頻繁充電，使用者體驗不佳。
*   **純視覺辨識演算法 (Software-only CV):**
    *   **現有技術：** 利用 OpenCV 結合機器學習模型計算姿態，通常僅於電腦螢幕彈出警告視窗。
    *   **侷限性：** 缺乏實體世界的阻斷力，使用者極易忽略螢幕角落的提示。
*   **本案差異化 (Proposed Contribution):** 本設計將視覺演算法作為「感知層」，ESP32 作為「執行層」，並新增網頁端作為「應用展示層」。利用攝影機達成無感監測，再利用 ESP32 驅動物理環境進行反饋。不僅如此，本案將過往僅能存放於本地端（如 posture_log.csv）的生硬數據轉化為動態網頁圖表，提供使用者即時評分與歷史回顧，為目前文獻中較少見的虛實整合與數據驅動解決方案。

## 3. Proposed Design / 規格書

### 3.1 系統架構 (System Architecture)
本系統採用發布/訂閱 (Publish/Subscribe) 模型進行模組化設計：
*   **Node A (感知節點):** 邊緣運算主機 + Webcam。負責運行 Python 環境與姿勢估計模型，並將推論數據（如前傾角度、側傾偏差等）打包發布。
*   **Broker (訊息中樞):** MQTT 伺服器，負責非同步訊息路由。
*   **Node B (執行節點):** ESP-WROOM-32 系統核心。負責訂閱狀態主題，並執行硬體中斷與狀態機切換。
*   **Node C (視覺化儀表板節點):** 負責訂閱感測數據與讀取歷史紀錄檔，透過 Web Server 將資料渲染為圖表與評分介面，提供跨裝置的監控畫面。

### 3.2 硬體規格書 (Hardware Specifications)
*   **視覺輸入設備:** 1080p USB 攝影機模組。
*   **反饋模組:** ESP32。
*   **運算單元:** Raspberry Pi 4B 或 PC (執行 MediaPipe 模型運算與架設輕量網頁伺服器)。

### 3.3 軟體與通訊規範 (Software & Protocol Specs)
*   **視覺框架:** Google MediaPipe Pose (Python) + OpenCV。
*   **通訊協定:** MQTT, QoS 0/1 與 WebSocket (負責網頁即時串流)。
*   **網頁前後端框架:** 後端採用 Flask 或 FastAPI 提供 API 與 WebSocket 服務；前端使用 HTML/JavaScript 搭配 Chart.js 等圖表庫進行數據渲染。
*   **微控制器韌體:** FreeRTOS 架構 (Arduino C++)。

## 4. Detail Implementation
本專案之實作可劃分為四個核心開發階段：

### 4.1 電腦視覺與特徵工程 (Vision & Feature Engineering)
於感知節點擷取即時影像串流。使用 MediaPipe 提取人體上半身關鍵節點。
*   **演算法邏輯：** 透過計算耳朵 Z 軸座標與肩膀平面的相對深度，判斷是否發生「頸部前傾」。利用雙肩 Y 軸座標差值計算身體「傾斜度」。若數值超越設定之健康閾值超過 3 秒，則判定為姿勢異常，並將結果即時記錄至離線日誌（如 posture_log.csv）。

### 4.2 物聯網通訊層實作 (IoT Communication Layer)
建立 JSON 格式之狀態封包，例如 `{"status": "slouching", "angle": 15.2, "duration": 4.5}`。感知節點透過 Python paho-mqtt 將封包發布至特定 Topic。

### 4.3 ESP32 硬體反饋與 HA 連動 (Hardware Actuation)
ESP32 啟動後自動連線至區網並訂閱對應 Topic。
*   **異常初期 (1-3分鐘)：** ESP32 控制桌面 WS2812B 呼吸燈轉為黃色警示。
*   **異常中期 (>3分鐘)：** 燈光轉為紅色高頻閃爍，啟動蜂鳴器提示。
*   **HA 連動：** 同步狀態至 Home Assistant 觸發自動化腳本。

### 4.4 網頁視覺化儀表板與數據分析 (Web Dashboard & Data Visualization)
作為本系統的使用者互動核心，網頁儀表板將提供以下功能：
*   **即時數據呈現與網頁警示：** 透過 WebSocket 接收 Node A 的即時數據，儀表板上會即時顯示當下的「前傾角度 (V_neck_angle)」與「肩膀下沉量 (Shoulder_Drop)」。當觸發不良姿勢時，網頁端會同步彈出浮動警示通知 (Toast Notifications) 與音效。
*   **圖表狀況 (Interactive Charts)：** 系統會讀取後台的日誌檔，利用 Chart.js 繪製「單日/單週坐姿健康度折線圖」與「不良姿勢分佈圓餅圖」，讓使用者清楚掌握自己的主要問題是駝背還是烏龜頸。
*   **綜合評分系統 (Posture Score)：** 基於平滑化後的推論指標與維持標準姿勢的時間佔比，演算法會即時計算出一個 0-100 的健康評分。使用者登入網頁即可直觀地看到當日分數，提升改善姿態的遊戲化成就感。

## 5. Conclusion
本期中提案規劃了一套高整合度的智慧坐姿監修系統。我們捨棄了傳統單一微控制器運算力不足，或單一電腦視覺缺乏環境反饋的缺點，利用 MQTT 協定將 MediaPipe 的強大辨識能力與 ESP32 的靈活硬體控制完美結合。更進一步導入了視覺化網頁儀表板，將感測數據轉化為具有參考價值的圖表與即時評分。此分散式架構不僅具備高擴充性，也符合現代智慧物聯網 (AIoT) 的工業設計標準，預期將能有效達成無感健康監測、高效率實體警示以及長期自主數據追蹤之多重目標。

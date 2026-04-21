# 01-整合舊專案 (Integrate AIoT Final Project)

## Why
為了集中管理開發資產，需要將之前位於 `https://github.com/teddywang0824/AIoT_Final_Project` 的舊版專案內容（包含系統架構設計文件、簡報與對話紀錄）整合至目前的專案儲存庫中。這有助於後續開發時能隨時取得先前的架構與設計參考。

## What Changes
- 從 `AIoT_Final_Project` GitHub 儲存庫取得所有舊有檔案 (PDF, PPTX, MD文件)。
- 將這些檔案轉移至目前專案的 `docs/legacy` (或其他指定的展示用目錄) 中以供後續查閱。
- 將 `c01-integrate-aiot-final-project` 變更的相關文件標題加上 `01-` 流水號前綴。

## Capabilities

### New Capabilities
- `c01-legacy-integration`: 舊有專案文件的集中管理與整合，作為未來 `01-系統架構設計` 等文件的基礎參考資料。

### Modified Capabilities
(無)

## Impact
- **檔案系統**: 會增加額外的靜態文件目錄（如 `docs/legacy`）與約 20MB 的文件檔案。
- **後續開發**: 不影響現有程式碼架構，但能顯著提升對過去設計決策的可追溯性。

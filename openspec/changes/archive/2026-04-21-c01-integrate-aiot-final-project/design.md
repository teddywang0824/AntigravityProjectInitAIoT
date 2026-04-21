# 01-整合舊專案技術設計 (Integration Design)

## Context
本專案 (AntiGravityProjectInitAIoT) 需要參考先前的 AIoT_Final_Project 舊專案所開發的系統架構與設計理念。舊專案儲存庫中包含珍貴的架構設計圖、簡報以及開發對話紀錄，但因為分散存放，對開發者來說檢索不易。

## Goals / Non-Goals

**Goals:**
- 將舊有專案 (`AIoT_Final_Project`) 中的所有文件與知識轉移至本儲存庫的子目錄中管理。
- 建立一個固定且標準的存放路徑，讓未來所有類似歷史文件都能夠統一存放。

**Non-Goals:**
- 不對舊有專案的內容進行修改或重新排版。
- 不將舊專案的 Git Commit 紀錄整合進來，僅匯入目前最終的檔案版本。

## Decisions

1. **檔案存放路徑決策**:
   - 將舊專案檔案放置於專案根目錄的 `docs/legacy/`。
   - **Rationale**: 區分新撰寫的 OpenSpec 規格 (`openspec/`) 與舊有歷史參考資料 (`docs/legacy/`)，避免混淆。

2. **保留大型二進位檔**:
   - 儘管 `PPTX` 與 `PDF` 會佔用空間（總計約 20MB），但考量其視覺圖表無可取代，我們允許將這些檔案直接進入本專案版控。若未來發現過大，再考慮改用 Git LFS 管理。

## Risks / Trade-offs
- **[風險: Git History 肥大]** → Mitigation: 僅匯入最後版本，不包含舊有 `.git/` 資料夾，且檔案大小約 20MB 仍在可接受範圍。

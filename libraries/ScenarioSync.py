import re
from datetime import datetime
from openpyxl import load_workbook


class ScenarioSync:
    """Robot Framework listener that writes test results back into the scenario spreadsheet.

    Usage:
        robot --listener libraries/ScenarioSync.py:data/test_scenarios.xlsx tests
    """

    ROBOT_LISTENER_API_VERSION = 3
    ID_PATTERN = re.compile(r"^(SC-\d+)")
    HEADER_ROW = 4
    FIRST_ROW = 5
    ID_COL, RESULT_COL, TIME_COL = 1, 10, 11

    def __init__(self, workbook_path="data/test_scenarios.xlsx", sheet="Test Scenarios"):
        self.workbook_path = workbook_path
        self.sheet = sheet
        self.results = {}

    def end_test(self, data, result):
        match = self.ID_PATTERN.match(result.name)
        if match:
            self.results[match.group(1)] = result.status

    def close(self):
        if not self.results:
            return
        try:
            wb = load_workbook(self.workbook_path)
            ws = wb[self.sheet]
            ws.cell(self.HEADER_ROW, self.RESULT_COL, "Last run result")
            ws.cell(self.HEADER_ROW, self.TIME_COL, "Last run time")
            stamp = datetime.now().strftime("%Y-%m-%d %H:%M")
            for row in range(self.FIRST_ROW, ws.max_row + 1):
                scenario_id = ws.cell(row, self.ID_COL).value
                if scenario_id in self.results:
                    ws.cell(row, self.RESULT_COL, self.results[scenario_id])
                    ws.cell(row, self.TIME_COL, stamp)
            wb.save(self.workbook_path)
        except PermissionError:
            print("ScenarioSync: close the spreadsheet in Excel and run again.")
        except KeyError:
            print(f"ScenarioSync: sheet '{self.sheet}' not found.")
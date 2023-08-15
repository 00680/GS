import json
import wx
from MainWindow import MainWindow

class App:
    def __init__(self):
        self.config = self.load_config()
        self.wx_app = wx.App(False)
        self.frame = MainWindow(None, "Launcher")
        self.frame.Show()

    def load_config(self):
        with open('./configs/config.json', 'r') as f:
            config = json.load(f)

        return config

    def start(self):
        self.frame.addProfile(self.config["userProfiles"][0])
        self.frame.fitSize()
        self.wx_app.MainLoop()


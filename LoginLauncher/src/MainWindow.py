import wx
import os

class MainWindow(wx.Frame):
    def __init__(self, parent, title):
        wx.Frame.__init__(self, parent, title=title, size=(200,-1))
        self.panel = wx.Panel(self, wx.ID_ANY)

        self.top_sizer = wx.BoxSizer(wx.VERTICAL)
        self.ctrl_sizer = wx.BoxSizer(wx.HORIZONTAL)
        self.profiles_sizer = wx.BoxSizer(wx.VERTICAL)

        add_profile_btn = wx.Button(self.panel, wx.ID_ANY, '新增')
        self.ctrl_sizer.Add(add_profile_btn, 0, wx.ALIGN_LEFT, 5)
        self.top_sizer.Add(self.ctrl_sizer, 0, wx.EXPAND|wx.ALL, 5)
        self.top_sizer.Add(wx.StaticLine(self.panel), 0, wx.ALL|wx.EXPAND, 5)
        self.top_sizer.Add(self.profiles_sizer , 0, wx.ALIGN_LEFT|wx.ALL,5)

        self.panel.SetSizerAndFit(self.top_sizer)
        self.top_sizer.Fit(self)

    def OnExit(self,e):
        self.Close(True)

    def addProfile(self,profile):
        profile_label = wx.StaticText(self.panel, -1, profile["profileName"])
        start_game_btn = wx.Button(self.panel, wx.ID_ANY, '開啟遊戲')
        edit_profile_btn = wx.Button(self.panel, wx.ID_ANY, '修改')
        delete_profile_btn = wx.Button(self.panel, wx.ID_ANY, '刪除')

        start_game_btn.profile = profile
        edit_profile_btn.profile = profile
        delete_profile_btn.profile = profile

        profile_sizer = wx.BoxSizer(wx.HORIZONTAL)
        profile_sizer.Add(start_game_btn, 1,wx.ALL,5)
        profile_sizer.Add(profile_label, 2,wx.ALIGN_LEFT|wx.ALL,5)
        profile_sizer.Add(edit_profile_btn, 1,wx.ALL,5)
        profile_sizer.Add(delete_profile_btn, 1,wx.ALL,5)
        self.profiles_sizer.Add(profile_sizer, wx.ALIGN_LEFT,5)

    def fitSize(self):
        self.panel.SetSizerAndFit(self.top_sizer)
        self.top_sizer.Fit(self)

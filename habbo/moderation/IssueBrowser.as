package com.sulake.habbo.moderation
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.window.class_38;
   
   public class IssueBrowser
   {
      
      private const MY_ISSUES:String = "my_issues";
      
      private const OPEN_ISSUES:String = "open_issues";
      
      private const PICKED_ISSUES:String = "picked_issues";
      
      private const CLOSED_ISSUES:String = "closed_issues";
      
      private var var_1945:IssueManager;
      
      private var _windowManager:class_38;
      
      private var _assets:class_40;
      
      private var _window:class_2250;
      
      private var _tabContext:ITabContextWindow;
      
      private var var_792:IIssueBrowserView;
      
      private var var_4764:IIssueBrowserView;
      
      private var var_4494:IIssueBrowserView;
      
      private var var_5054:PickedIssuesView;
      
      public function IssueBrowser(param1:IssueManager, param2:class_38, param3:class_40)
      {
         super();
         var_1945 = param1;
         _windowManager = param2;
         _assets = param3;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get assets() : class_40
      {
         return _assets;
      }
      
      public function get issueManager() : IssueManager
      {
         return var_1945;
      }
      
      public function show() : void
      {
         if(_window == null)
         {
            createMainFrame();
         }
         _window.visible = true;
         _window.activate();
         update();
      }
      
      public function isOpen() : Boolean
      {
         return _window != null && Boolean(_window.visible);
      }
      
      private function createMainFrame() : void
      {
         if(_window == null)
         {
            _window = createWindow("issue_browser_xml") as class_2250;
            if(_window == null)
            {
               return;
            }
            var _loc1_:class_1741 = _window.desktop;
            _window.x = null.width / 2 - _window.width / 2;
            _window.y = null.height / 2 - _window.height / 2;
            var _loc5_:class_1741 = _window.findChildByTag("close");
            if(_loc5_ != null)
            {
               null.addEventListener("WME_CLICK",onClose);
            }
            var _loc6_:class_1741 = _window.findChildByName("auto_pick");
            if(_loc6_ != null)
            {
               null.addEventListener("WME_CLICK",onAutoPick);
            }
            _tabContext = _window.findChildByName("tab_context") as ITabContextWindow;
            var _loc4_:int = 0;
            while(0 < _tabContext.numTabItems)
            {
               var _loc2_:ITabButtonWindow = _tabContext.getTabItemAt(0);
               null.addEventListener("WE_SELECTED",onTabSelected);
               _loc4_++;
            }
            var_4764 = new MyIssuesView(issueManager,this,_window.findChildByName("my_issues_prototype") as class_1812);
            var_4494 = new OpenIssuesView(issueManager,this,_window.findChildByName("open_issues_prototype") as class_1812);
            var_5054 = new PickedIssuesView(issueManager,this,_window.findChildByName("picked_issues_prototype") as class_1812);
         }
         _tabContext = _window.findChildByName("tab_context") as ITabContextWindow;
         if(_tabContext == null || _tabContext.container == null)
         {
            return;
         }
         var _loc3_:ISelectableWindow = _tabContext.selector.getSelectableByName("open_issues");
         _tabContext.selector.setSelected(_loc3_);
      }
      
      private function selectView(param1:String) : void
      {
         var _loc2_:IIssueBrowserView = getView(param1);
         if(var_792 == _loc2_)
         {
            return;
         }
         if(var_792 != null)
         {
            var_792.visible = false;
         }
         var_792 = _loc2_;
         if(var_792 == null)
         {
            return;
         }
         var_792.view.width = _tabContext.container.width;
         var_792.view.height = _tabContext.container.height;
         var_792.visible = true;
         var_792.update();
      }
      
      private function getView(param1:String) : IIssueBrowserView
      {
         switch(param1)
         {
            case "my_issues":
               return var_4764;
            case "open_issues":
               return var_4494;
            case "picked_issues":
               return var_5054;
            default:
               return null;
         }
      }
      
      private function onTabSelected(param1:class_1758) : void
      {
         if(param1 == null || param1.window == null)
         {
            return;
         }
         selectView(param1.window.name);
      }
      
      public function update() : void
      {
         if(_window == null || !_window.visible)
         {
            return;
         }
         if(var_792 == null)
         {
            return;
         }
         var_792.update();
      }
      
      public function createWindow(param1:String) : class_1741
      {
         if(_windowManager == null || _assets == null)
         {
            return null;
         }
         var _loc2_:XmlAsset = _assets.getAssetByName(param1) as XmlAsset;
         if(_loc2_ == null || _loc2_.content == null)
         {
            return null;
         }
         return _windowManager.buildFromXML(_loc2_.content as XML);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         _window.visible = false;
      }
      
      private function onAutoPick(param1:WindowMouseEvent) : void
      {
         if(var_1945 != null)
         {
            var_1945.autoPick("issue browser pick next");
         }
      }
   }
}


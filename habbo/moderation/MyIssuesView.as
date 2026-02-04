package com.sulake.habbo.moderation
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class MyIssuesView implements IIssueBrowserView
   {
      
      private var var_1945:IssueManager;
      
      private var var_1425:IssueBrowser;
      
      private var _window:class_1812;
      
      private var var_4270:IssueListView;
      
      public function MyIssuesView(param1:IssueManager, param2:IssueBrowser, param3:class_1812)
      {
         super();
         var_1945 = param1;
         var_1425 = param2;
         _window = param3;
         _window.visible = false;
         var _loc5_:IItemListWindow = _window.findChildByName("issue_list") as IItemListWindow;
         var_4270 = new IssueListView(param1,param2,_loc5_);
         var _loc4_:class_1741 = _window.findChildByName("release_all");
         if(_loc4_ != null)
         {
            _loc4_.addEventListener("WME_CLICK",onReturnAll);
         }
      }
      
      public function get view() : class_1812
      {
         return _window;
      }
      
      public function set visible(param1:Boolean) : void
      {
         _window.visible = param1;
      }
      
      public function update() : void
      {
         var _loc1_:Array = var_1945.getBundles("issue_bundle_my");
         var_4270.update(_loc1_);
      }
      
      private function onReturnAll(param1:WindowMouseEvent) : void
      {
         if(var_1945 == null)
         {
            return;
         }
         var_1945.releaseAll();
      }
   }
}


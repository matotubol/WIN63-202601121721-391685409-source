package com.sulake.habbo.moderation
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   
   public class OpenIssuesView implements IIssueBrowserView
   {
      
      private var var_1945:IssueManager;
      
      private var var_1425:IssueBrowser;
      
      private var _window:class_1812;
      
      private var var_4270:IssueListView;
      
      public function OpenIssuesView(param1:IssueManager, param2:IssueBrowser, param3:class_1812)
      {
         super();
         var_1945 = param1;
         var_1425 = param2;
         _window = param3;
         _window.visible = false;
         var _loc4_:IItemListWindow = _window.findChildByName("issue_list") as IItemListWindow;
         var_4270 = new IssueListView(param1,param2,_loc4_);
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
         var _loc1_:Array = var_1945.getBundles("issue_bundle_open");
         var_4270.update(_loc1_);
      }
   }
}


package com.sulake.habbo.navigator
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.class_1758;
   
   public class TextSearchInputs
   {
      
      private var _navigator:HabboNavigator;
      
      private var var_1341:TextFieldManager;
      
      private var var_857:class_2261;
      
      public function TextSearchInputs(param1:HabboNavigator, param2:class_1812)
      {
         super();
         _navigator = param1;
         var _loc3_:ITextFieldWindow = ITextFieldWindow(param2.findChildByName("search_str"));
         var_1341 = new TextFieldManager(_navigator,_loc3_,35,searchRooms,_navigator.getText("navigator.search.info"));
         Util.setProc(param2,"search_but",onSearchButtonClick);
         var _loc5_:Boolean = true;
         if(_loc5_)
         {
            var_857 = param2.findChildByName("search_type") as class_2261;
            var _loc4_:Array = [];
            _loc4_.push(_navigator.getText("${navigator.navisel.bydefault}"));
            null.push(_navigator.getText("${navigator.navisel.byowner}"));
            null.push(_navigator.getText("${navigator.navisel.byroomname}"));
            null.push(_navigator.getText("${navigator.navisel.bytag}"));
            null.push(_navigator.getText("${navigator.navisel.bygroupname}"));
            var_857.populate(null);
            var_857.selection = 0;
         }
      }
      
      public function dispose() : void
      {
         if(var_1341)
         {
            var_1341.dispose();
            var_1341 = null;
         }
         _navigator = null;
      }
      
      public function setText(param1:String, param2:int) : void
      {
         var_1341.setText(param1);
         if(var_857 != null)
         {
            switch(param2 - 8)
            {
               case 0:
                  var_857.selection = 0;
                  break;
               case 1:
                  var_857.selection = 3;
                  break;
               case 2:
                  var_857.selection = 2;
                  break;
               case 5:
                  var_857.selection = 4;
                  break;
               case 12:
                  var_857.selection = 1;
            }
         }
      }
      
      private function onSearchButtonClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         searchRooms();
      }
      
      private function searchRooms() : void
      {
         var _loc1_:String = var_1341.getText();
         if(_loc1_ == "")
         {
            return;
         }
         if(var_857 != null)
         {
            switch(var_857.selection)
            {
               case 0:
                  _navigator.mainViewCtrl.startSearch(5,8,_loc1_);
                  break;
               case 1:
                  _navigator.mainViewCtrl.startSearch(5,20,_loc1_);
                  break;
               case 2:
                  _navigator.mainViewCtrl.startSearch(5,10,_loc1_);
                  break;
               case 3:
                  _navigator.mainViewCtrl.startSearch(5,9,_loc1_);
                  break;
               case 4:
                  _navigator.mainViewCtrl.startSearch(5,13,_loc1_);
            }
         }
         else
         {
            _navigator.mainViewCtrl.startSearch(5,8,_loc1_);
         }
         _navigator.trackNavigationDataPoint("Search","search",_loc1_);
      }
      
      public function get searchStr() : TextFieldManager
      {
         return var_1341;
      }
   }
}


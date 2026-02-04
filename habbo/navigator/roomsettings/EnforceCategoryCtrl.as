package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.navigator.class_42;
   import com.sulake.habbo.window.utils.IModalDialog;
   import package_104.class_3533;
   import package_42.class_3364;
   
   public class EnforceCategoryCtrl
   {
      
      private var _navigator:class_42;
      
      private var _window:class_2250;
      
      private var var_393:IModalDialog;
      
      private var var_2551:int = 0;
      
      private var var_4453:int = 0;
      
      private var var_1904:Array = [];
      
      public function EnforceCategoryCtrl(param1:class_42)
      {
         super();
         _navigator = param1;
      }
      
      public function show(param1:int) : void
      {
         close();
         var_393 = _navigator.windowManager.buildModalDialogFromXML(_navigator.assets.getAssetByName("enforce_category_xml").content as XML);
         _window = var_393.rootWindow as class_2250;
         _window.procedure = windowProcedure;
         _window.center();
         _window.findChildByName("header_button_close").visible = false;
         var _loc2_:class_2261 = _window.findChildByName("trade_mode") as class_2261;
         var _loc5_:Array = [];
         _loc5_.push("${navigator.roomsettings.trade_not_allowed}");
         _loc5_.push("${navigator.roomsettings.trade_not_with_Controller}");
         _loc5_.push("${navigator.roomsettings.trade_allowed}");
         _loc2_.populate(_loc5_);
         _loc2_.selection = 0;
         var _loc6_:class_2261 = _window.findChildByName("category") as class_2261;
         var_1904 = [];
         for each(var _loc7_ in _navigator.data.visibleCategories)
         {
            if(!_loc7_.automatic && (!_loc7_.staffOnly || _loc7_.staffOnly && _navigator.sessionData.hasSecurity(7)))
            {
               var_1904.push(_loc7_);
            }
         }
         var _loc3_:Array = [];
         for each(var _loc4_ in var_1904)
         {
            _loc3_.push(_loc4_.visibleName);
         }
         _loc6_.populate(_loc3_);
         _loc6_.selection = 0;
      }
      
      private function close() : void
      {
         if(var_393 && _window)
         {
            var_393.dispose();
            var_393 = null;
            _window = null;
         }
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:int = 0;
         if(param1.type == "WME_CLICK")
         {
            var _loc4_:* = param2.name;
            if("ok" === _loc4_)
            {
               _loc3_ = int(class_3364(var_1904[Math.max(0,var_2551)]).nodeId);
               _navigator.communication.connection.send(new class_3533(_navigator.data.currentRoomId,_loc3_,var_4453));
               close();
            }
         }
         else if(param1.type == "WE_SELECTED")
         {
            switch(param2.name)
            {
               case "category":
                  var_2551 = class_2261(param2).selection;
                  break;
               case "trade_mode":
                  var_4453 = class_2261(param2).selection;
            }
         }
      }
   }
}


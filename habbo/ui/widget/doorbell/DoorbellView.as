package com.sulake.habbo.ui.widget.doorbell
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class DoorbellView
   {
      
      private var var_552:DoorbellWidget;
      
      private var _frame:class_2250;
      
      private var var_121:IItemListWindow;
      
      public function DoorbellView(param1:DoorbellWidget)
      {
         super();
         var_552 = param1;
      }
      
      public function dispose() : void
      {
         var_121 = null;
         var_552 = null;
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
      }
      
      public function update() : void
      {
         var _loc1_:int = 0;
         if(var_552.users.length == 0)
         {
            hide();
            return;
         }
         if(_frame == null)
         {
            createMainWindow();
         }
         _frame.visible = true;
         if(var_121 != null)
         {
            var_121.destroyListItems();
            _loc1_ = 0;
            while(_loc1_ < var_552.users.length)
            {
               var_121.addListItem(createListItem(var_552.users[_loc1_] as String,_loc1_));
               _loc1_++;
            }
         }
      }
      
      public function get mainWindow() : class_1741
      {
         return _frame;
      }
      
      private function createListItem(param1:String, param2:int) : class_1741
      {
         var _loc5_:class_1741 = null;
         var _loc4_:XmlAsset = var_552.assets.getAssetByName("doorbell_list_entry") as XmlAsset;
         var _loc3_:class_1812 = var_552.windowManager.buildFromXML(_loc4_.content as XML) as class_1812;
         if(_loc3_ == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var _loc6_:ITextWindow = _loc3_.findChildByName("user_name") as ITextWindow;
         if(_loc6_ != null)
         {
            _loc6_.caption = param1;
         }
         _loc3_.name = param1;
         if(param2 % 2 == 0)
         {
            _loc3_.color = 4294967295;
         }
         _loc5_ = _loc3_.findChildByName("accept");
         if(_loc5_ != null)
         {
            _loc5_.addEventListener("WME_CLICK",onButtonClicked);
         }
         _loc5_ = _loc3_.findChildByName("deny");
         if(_loc5_ != null)
         {
            _loc5_.addEventListener("WME_CLICK",onButtonClicked);
         }
         return _loc3_;
      }
      
      private function hide() : void
      {
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
      }
      
      private function createMainWindow() : void
      {
         if(_frame != null)
         {
            return;
         }
         var _loc2_:XmlAsset = var_552.assets.getAssetByName("doorbell") as XmlAsset;
         _frame = var_552.windowManager.buildFromXML(_loc2_.content as XML) as class_2250;
         if(_frame == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var_121 = _frame.findChildByName("user_list") as IItemListWindow;
         _frame.visible = false;
         var _loc1_:class_1741 = _frame.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",onClose);
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         var_552.denyAll();
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:String = param1.window.parent.name;
         switch(param1.window.name)
         {
            case "accept":
               var_552.accept(_loc2_);
               break;
            case "deny":
               var_552.deny(_loc2_);
         }
      }
   }
}


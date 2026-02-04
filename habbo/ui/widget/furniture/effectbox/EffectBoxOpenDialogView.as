package com.sulake.habbo.ui.widget.furniture.effectbox
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
   import com.sulake.habbo.window.class_38;
   import package_55.class_2945;
   
   public class EffectBoxOpenDialogView implements class_13
   {
      
      private static const const_202:String = "header_button_close";
      
      private static const const_207:String = "cancel";
      
      private static const const_147:String = "ok";
      
      private var _window:class_1812;
      
      private var _disposed:Boolean = false;
      
      private var var_16:FurnitureContextMenuWidget;
      
      private var _windowManager:class_38;
      
      private var _assets:class_40;
      
      private var var_2338:int;
      
      public function EffectBoxOpenDialogView(param1:FurnitureContextMenuWidget)
      {
         super();
         var_16 = param1;
         _windowManager = param1.windowManager;
         _assets = var_16.assets;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _disposed = true;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function open(param1:int) : void
      {
         var_2338 = param1;
         setWindowContent();
         _window.visible = true;
      }
      
      private function setWindowContent() : void
      {
         var _loc1_:String = null;
         if(!_window)
         {
            _loc1_ = "effectbox_xml";
            _window = _windowManager.buildFromXML(_assets.getAssetByName(_loc1_).content as XML) as class_1812;
            addClickListener("ok");
            addClickListener("cancel");
            addClickListener("header_button_close");
            _window.center();
         }
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      private function addClickListener(param1:String) : void
      {
         _window.findChildByName(param1).addEventListener("WME_CLICK",onMouseClick);
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel":
               close();
               break;
            case "ok":
               connection.send(new class_2945(var_2338));
               close();
         }
      }
      
      private function get connection() : IConnection
      {
         return var_16.handler.container.connection;
      }
   }
}


package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   
   public class NewUserHelpView extends AvatarContextInfoButtonView
   {
      
      private var _caption:String = "";
      
      public function NewUserHelpView(param1:AvatarInfoWidget)
      {
         super(param1);
         _caption = param1.localization.getLocalization("room.enter.infostand.caption","");
         var_3745 = param1.configuration.getInteger("room.enter.infostand.fade.start.delay",5000);
      }
      
      public static function setup(param1:AvatarContextInfoButtonView, param2:int, param3:String, param4:int, param5:int) : void
      {
         AvatarContextInfoButtonView.setup(param1,param2,param3,param4,param5,false);
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         if(!var_16 || !var_16.assets || !var_16.windowManager)
         {
            return;
         }
         if(!_window)
         {
            _loc1_ = var_16.assets.getAssetByName("new_user_help").content as XML;
            _window = var_16.windowManager.buildFromXML(_loc1_,0) as class_1812;
            if(!_window)
            {
               return;
            }
            var _loc2_:class_1741 = _window.findChildByName("help");
            null.caption = _caption;
            _window.invalidate();
         }
         activeView = _window;
      }
      
      public function get widget() : AvatarInfoWidget
      {
         return var_16 as AvatarInfoWidget;
      }
   }
}


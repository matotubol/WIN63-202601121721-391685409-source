package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.friendlist.class_2242;
   import com.sulake.habbo.ui.widget.contextmenu.ButtonMenuView;
   import com.sulake.habbo.ui.widget.contextmenu.class_1853;
   import flash.geom.Rectangle;
   
   public class AvatarContextInfoButtonView extends ButtonMenuView
   {
      
      protected var var_1270:int;
      
      protected var _userName:String;
      
      protected var var_3359:int;
      
      protected var var_3322:Boolean;
      
      protected var var_3915:int;
      
      protected var var_996:Boolean;
      
      public function AvatarContextInfoButtonView(param1:class_1853)
      {
         super(param1);
      }
      
      public static function setup(param1:AvatarContextInfoButtonView, param2:int, param3:String, param4:int, param5:int, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false) : void
      {
         param1.var_1270 = param2;
         param1._userName = param3;
         param1.var_3359 = param5;
         param1.var_3915 = param4;
         param1.var_3322 = param6;
         param1.var_236 = param7;
         param1.var_996 = param8;
         setupContext(param1);
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get userType() : int
      {
         return var_3359;
      }
      
      public function get roomIndex() : int
      {
         return var_3915;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get allowNameChange() : Boolean
      {
         return var_3322;
      }
      
      public function get isBlocked() : Boolean
      {
         return isBlocked;
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         var _loc3_:class_1741 = null;
         if(!var_16 || !var_16.assets || !var_16.windowManager)
         {
            return;
         }
         if(!_window)
         {
            _loc1_ = var_16.assets.getAssetByName("avatar_info_widget").content as XML;
            _window = var_16.windowManager.buildFromXML(_loc1_,0) as class_1812;
            if(!_window)
            {
               return;
            }
         }
         var _loc2_:ITextWindow = _window.findChildByName("name") as ITextWindow;
         if(var_996)
         {
            _loc2_.italic = true;
            _loc2_.caption = "${infostand.blocked_user}";
         }
         else
         {
            _loc2_.italic = false;
            _window.findChildByName("name").caption = _userName;
         }
         updateRelationshipStatus();
         if(!var_3322)
         {
            _window.findChildByName("change_name_container").visible = false;
            _window.height = 39;
         }
         else
         {
            _loc3_ = _window.findChildByName("change_name_container");
            _loc3_.visible = true;
            _window.height = 39 + _loc3_.height;
            addMouseClickListener(_window.findChildByName("change_name_container"),clickHandler);
         }
         activeView = _window;
      }
      
      override protected function getOffset(param1:Rectangle) : int
      {
         var _loc2_:int = -var_125.height;
         if(var_3359 == 1 || var_3359 == 3 || var_3359 == 4)
         {
            _loc2_ += param1.height > 50 ? 25 : 0;
         }
         else
         {
            _loc2_ -= 4;
         }
         return _loc2_;
      }
      
      protected function updateRelationshipStatus() : void
      {
         var _loc1_:IStaticBitmapWrapperWindow = null;
         if(var_16 && var_16.friendList)
         {
            _loc1_ = IStaticBitmapWrapperWindow(_window.findChildByName("relationship_status"));
            _loc1_.assetUri = "relationship_status_" + class_2242.statusAsString(var_16.friendList.getRelationshipStatus(userId));
         }
      }
   }
}


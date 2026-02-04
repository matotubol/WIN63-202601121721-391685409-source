package com.sulake.habbo.friendbar.talent
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.habbo.utils.class_2724;
   import com.sulake.habbo.window.widgets.class_2478;
   import package_187.class_3929;
   
   public class TalentProgressMeter implements class_13
   {
      
      private const ACHIEVED_DIVIDER:String = "talent_achieved_div";
      
      private const UNACHIEVED_DIVIDER:String = "talent_unachieved_div";
      
      private const DIVIDER_WINDOW_PREFIX:String = "progress_divider_level_";
      
      private const AVATAR_GLOW_RADIUS:int = 10;
      
      private var _disposed:Boolean = false;
      
      private var _habboTalent:HabboTalent;
      
      private var var_55:TalentTrackController;
      
      private var _talentTrack:class_3929;
      
      private var var_378:class_1812;
      
      private var _divider:IStaticBitmapWrapperWindow;
      
      private var var_498:class_2010;
      
      private var var_3238:IStaticBitmapWrapperWindow;
      
      private var var_2950:IStaticBitmapWrapperWindow;
      
      public function TalentProgressMeter(param1:HabboTalent, param2:TalentTrackController)
      {
         super();
         _habboTalent = param1;
         var_55 = param2;
         _talentTrack = var_55.talentTrack;
         createMeter();
      }
      
      public function get width() : int
      {
         return var_55.window.width;
      }
      
      public function get progressPerLevelWidth() : int
      {
         return int(Math.floor(class_2724.lerp(_talentTrack.progressPerLevel,0,width)));
      }
      
      private function createMeter() : void
      {
         var_378 = class_1812(var_55.window.findChildByName("progress_container"));
         _divider = IStaticBitmapWrapperWindow(var_378.removeChild(var_378.findChildByName("progress_level_divider")));
         var_3238 = IStaticBitmapWrapperWindow(var_378.findChildByName("achieved_mid"));
         var_2950 = IStaticBitmapWrapperWindow(var_378.findChildByName("unachieved_mid"));
         var _loc2_:int = 1;
         while(0 < _talentTrack.levels.length)
         {
            var _loc1_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_divider.clone());
            null.name = "progress_divider_level_" + 0;
            var_378.addChild(null);
            _loc2_++;
         }
         var_498 = class_2010(var_378.findChildByName("progress_needle"));
         class_2478(var_498.widget).figure = _habboTalent.sessionManager.figure;
         var_378.setChildIndex(var_498,var_378.numChildren - 1);
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_divider)
            {
               _divider.dispose();
               _divider = null;
            }
            var_3238 = null;
            var_2950 = null;
            var_498 = null;
            var_378 = null;
            _talentTrack = null;
            var_55 = null;
            _habboTalent = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function resize() : void
      {
         var _loc5_:int = 0;
         var _loc4_:IStaticBitmapWrapperWindow = null;
         var _loc1_:int = Math.floor(class_2724.lerp(_talentTrack.totalProgress,0,width));
         var_378.width = width;
         var_2950.width = width;
         var_3238.width = _loc1_;
         var_498.x = class_2724.clamp(_loc1_ - int(var_498.width / 2),0,width - var_498.width);
         var _loc2_:class_1741 = var_378.findChildByName("avatar_glow");
         _loc2_.x = var_498.x - 10;
         _loc2_.y = var_498.y - 10;
         _loc2_.width = var_498.width + 2 * 10;
         _loc2_.height = var_498.height + 2 * 10;
         var _loc3_:class_1741 = var_378.findChildByName("progress_balloon");
         _loc3_.x = var_498.x + Math.floor(var_498.width / 2) - Math.floor(_loc3_.width / 2) + 5;
         _loc5_ = 1;
         while(_loc5_ < _talentTrack.levels.length)
         {
            _loc4_ = IStaticBitmapWrapperWindow(var_378.findChildByName("progress_divider_level_" + _loc5_));
            _loc4_.x = _loc5_ * progressPerLevelWidth;
            if(_loc4_.x < _loc1_)
            {
               _loc4_.assetUri = "talent_achieved_div";
            }
            else
            {
               _loc4_.assetUri = "talent_unachieved_div";
            }
            _loc4_.visible = true;
            _loc5_++;
         }
         var_378.invalidate();
      }
   }
}


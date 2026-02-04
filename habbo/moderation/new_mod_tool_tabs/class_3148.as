package com.sulake.habbo.moderation.new_mod_tool_tabs
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IIconButtonWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.moderation.class_1852;
   import flash.utils.setTimeout;
   
   [SecureSWF(rename="true")]
   public class class_3148 extends class_2613
   {
      
      private static var PLAY_SOUND_DELAY:int = 250;
      
      private static var PLAY_SOUNDS:Array = ["HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase","HBST_pixels","HBST_message_received","HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase","HBST_pixels","HBST_pixels","HBST_pixels","HBST_pixels","HBST_pixels","HBST_purchase","HBST_purchase","HBST_purchase","FURNITURE_cuckoo_clock","FURNITURE_cuckoo_clock","FURNITURE_cuckoo_clock","FURNITURE_cuckoo_clock","HBST_message_received","HBST_message_received","HBST_message_received","HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase","HBST_pixels","HBST_message_received","HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase","HBST_pixels","HBST_pixels","HBST_pixels","HBST_pixels","HBST_pixels","HBST_purchase","HBST_purchase","HBST_purchase"
      ,"FURNITURE_cuckoo_clock","FURNITURE_cuckoo_clock","FURNITURE_cuckoo_clock","FURNITURE_cuckoo_clock","HBST_message_received","HBST_message_received","HBST_message_received","HBST_purchase","HBST_purchase","HBST_purchase","HBST_purchase"];
      
      private var _originalVolume:Number = 0;
      
      public function class_3148(param1:class_1852, param2:class_1812)
      {
         super(param1,param2);
         plusButton.addEventListener("WME_CLICK",onPlusButtonClick);
         minusButton.addEventListener("WME_CLICK",onMinusButtonClick);
         donateCoinsButton.addEventListener("WME_CLICK",onDonateCoinsClick);
      }
      
      private function onDonateCoinsClick(param1:WindowMouseEvent) : void
      {
         amount = 1;
         playAllSounds();
         donateCoinsButton.disable();
      }
      
      private function playAllSounds() : void
      {
         _originalVolume = tool.soundManager.genericVolume;
         if(_originalVolume < 0.4)
         {
            tool.soundManager.genericVolume = 0.4;
         }
         else if(_originalVolume > 0.6)
         {
            tool.soundManager.genericVolume = 0.6;
         }
         var _loc1_:int = 0;
         while(0 < PLAY_SOUNDS.length)
         {
            setTimeout(playSound,0 * PLAY_SOUND_DELAY,PLAY_SOUNDS[0]);
            _loc1_++;
         }
         setTimeout(halfWay,PLAY_SOUNDS.length * PLAY_SOUND_DELAY / 2);
         setTimeout(soundsFinished,PLAY_SOUNDS.length * PLAY_SOUND_DELAY);
      }
      
      private function playSound(param1:String) : void
      {
         tool.soundManager.playSound(param1);
      }
      
      private function halfWay() : void
      {
         tool.notifications.addItem("${generic.is_this_trax}","soundmachine");
      }
      
      private function soundsFinished() : void
      {
         donateCoinsButton.enable();
         tool.setToolCompletion(3);
         if(tool.soundManager.genericVolume != _originalVolume)
         {
            tool.soundManager.genericVolume = _originalVolume;
         }
      }
      
      override public function onOpen() : void
      {
         super.onOpen();
         usernameInput.text = tool.sessionDataManager.userName;
      }
      
      private function onPlusButtonClick(param1:WindowMouseEvent) : void
      {
         if(amount < 99999)
         {
            amount += 1;
         }
      }
      
      private function onMinusButtonClick(param1:WindowMouseEvent) : void
      {
         if(amount > 1)
         {
            amount -= 1;
         }
      }
      
      private function get amount() : int
      {
         return parseInt(amountCoinsInput.text);
      }
      
      private function set amount(param1:int) : void
      {
         amountCoinsInput.text = "" + param1;
      }
      
      private function get usernameInput() : ITextFieldWindow
      {
         return window.findChildByName("give_coins_username_input") as ITextFieldWindow;
      }
      
      private function get amountCoinsInput() : ITextFieldWindow
      {
         return window.findChildByName("amount_coins_input") as ITextFieldWindow;
      }
      
      private function get plusButton() : IIconButtonWindow
      {
         return window.findChildByName("plus_btn_coins") as IIconButtonWindow;
      }
      
      private function get minusButton() : IIconButtonWindow
      {
         return window.findChildByName("minus_btn_coins") as IIconButtonWindow;
      }
      
      private function get donateCoinsButton() : class_1775
      {
         return window.findChildByName("add_coins_btn") as class_1775;
      }
   }
}


import board
import digitalio
import time

class PresenceSensor:
    def _init_(self):
        self.objectDetected = digitalio.DigitalInOut(board.D11)
        self.objectDetected.direction = digitalio.Direction.INPUT
    def checkPresenece(self):
        return self.objectDetected.value
                
class SmileySpeakerOutput:
    def _init_(self):
        self.speakerOn = digitalio.DigitalInOut(board.D12)
        self.speakerOn.direction = digitalio.Direction.OUTPUT
        self.smileyOn = digitalio.DigitalInOut(board.D13)
        self.smileyOn.direction = digitalio.Direction.OUTPUT
        self.onDelay = 0.5
    def trigger(self):
        speakerOn.value = True
        smileyOn.value = True
        time.sleep(self.onDelay)
        speakerOn.value = False
        smileyOn.value = False

class EasyStateMachine:
    NO_OBJECT_OUTPUT_NO_TRIGGER = 0
    OBJECT_OUTPUT_ALREADY_TRIGGERED = 1

    def _init_(self):
        self.smiley_speaker = SmileySpeakerOutput()
        self.presence_sensor = PresenceSensor()
        self.object_in_view = False
    def determineState(self, objectPresent):
        if (self.object_in_view == False and
        objectPresent == True):
            SmileySpeakerOutput.trigger()
            self.object_in_view = True
        elif (self.object_in_view == True and
        objectPresent == False):
            self.object_in_view = False
        return     
    
while True:


    
import numpy as np
from rlbench.action_modes.action_mode import MoveArmThenGripper
from rlbench.action_modes.arm_action_modes import JointVelocity
from rlbench.action_modes.gripper_action_modes import Discrete
from rlbench.environment import Environment
from rlbench.observation_config import ObservationConfig
from rlbench.tasks import StackWine,PlaceCups,PutKnifeInKnifeBlock,LampOn,StackBlocks,\
    OpenDrawer,StackCups,InsertOntoSquarePeg, InsertUsbInComputer, PutRubbishInBin,\
    PutShoesInBox,CloseJar,EmptyContainer,HangFrameOnHanger,HitBallWithQueue, MeatOffGrill,PlaceShapeInShapeSorter, \
    PlugChargerInPowerSupply, PutBooksOnBookshelf, PutPlateInColoredDishRack, SetupCheckers, SweepToDustpan,\
    PutAllGroceriesInCupboard, PlaceWineAtRackLocation, PutGroceriesInCupboard, LightBulbIn, SlideBlockToColorTarget



class ImitationLearning(object):

    def predict_action(self, batch):
        return np.random.uniform(size=(len(batch), 7))

    def behaviour_cloning_loss(self, ground_truth_actions, predicted_actions):
        return 1


# To use 'saved' demos, set the path below, and set live_demos=False
live_demos = True
DATASET = '' if live_demos else 'PATH/TO/YOUR/DATASET'

obs_config = ObservationConfig()
obs_config.set_all(True)

env = Environment(
    action_mode=MoveArmThenGripper(
        arm_action_mode=JointVelocity(), gripper_action_mode=Discrete()),
    obs_config=ObservationConfig(),
    headless=False)
env.launch()
task = env.get_task(SlideBlockToColorTarget)
il = ImitationLearning()

demos = task.get_demos(10, live_demos=live_demos)  # -> List[List[Observation]]
demos = np.array(demos).flatten()
print(demos)

import matplotlib.pyplot as plt

for demo in demos:
    gripper_open_history, ignore_collision_history = [], []
    for i in range(len(demo)):
        gripper_open_history.append(demo[i].gripper_open)
        ignore_collision_history.append(demo[i].ignore_collisions)
    gripper_open_history, ignore_collision_history = \
        np.asarray(gripper_open_history), np.asarray(ignore_collision_history)

    plt.figure()
    plt.plot(gripper_open_history, label='gripper_open')
    plt.plot(ignore_collision_history, label='ignore_collision')
    plt.legend()
    plt.show()

# An example of using the demos to 'train' using behaviour cloning loss.
for i in range(10):
    print("'training' iteration %d" % i)
    batch = np.random.choice(demos, replace=False)
    batch_images = [obs.left_shoulder_rgb for obs in batch]
    predicted_actions = il.predict_action(batch_images)
    ground_truth_actions = [obs.joint_velocities for obs in batch]
    loss = il.behaviour_cloning_loss(ground_truth_actions, predicted_actions)

print('Done')
env.shutdown()
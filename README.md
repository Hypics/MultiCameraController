# Multi Camera Controller

## Installation

### Ruby

```bash
brew install ruby
```

```bash
echo 'if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi' >> ~/.zshrc
```

### Cocoapods

```bash
sudo gem pristine ffi --version 1.15.5 \
  && sudo gem install cocoapods
```

### Project (Pod)

```bash
pod install
```

- Open ***MultiCameraController.xcworkspace***

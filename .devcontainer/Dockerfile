FROM aiplanning/planutils:latest

# Ativar o ambiente planutils
RUN planutils activate

RUN apt-get update && apt-get install -y python3-pip && \
    pip3 install flask && \
    rm -rf /var/lib/apt/lists/*

# Instalar os solvers mais comuns usados no planning.domains
RUN planutils install -y downward
RUN planutils install -y lama          
RUN planutils install -y cerberus
RUN planutils install -y delfi
RUN planutils install -y enhsp
RUN planutils install -y forbiditerative
RUN planutils install -y hpddl2pddl
RUN planutils install -y kstar        
RUN planutils install -y optic
RUN planutils install -y planning.domains
RUN planutils install -y pyperplan
RUN planutils install -y scorpion
RUN planutils install -y smtplan
RUN planutils install -y tarski
RUN planutils install -y tfd
RUN planutils install -y val

EXPOSE 5555

CMD ["planutils", "server", "--port", "5555"]